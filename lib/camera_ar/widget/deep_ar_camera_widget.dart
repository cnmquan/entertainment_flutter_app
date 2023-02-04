import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/widget.dart';
import '../utils.dart';

class DeepArCameraWidget extends StatefulWidget {
  const DeepArCameraWidget({Key? key}) : super(key: key);

  @override
  State<DeepArCameraWidget> createState() => _DeepArCameraWidgetState();
}

class _DeepArCameraWidgetState extends State<DeepArCameraWidget> {
  DeepArController? _controller;

  @override
  void initState() {
    _controller = DeepArController()
      ..initialize(
        androidLicenseKey: DeepArKey.androidDeepARKey,
        iosLicenseKey: DeepArKey.iosDeepARKey,
        resolution: Resolution.high,
      ).then((_) => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    if (_controller != null) {
      if (_controller!.isInitialized) {
        _controller!.destroy();
      }
    }
    _controller = null;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.passthrough,
      children: [
        if (_controller != null)
          if (_controller!.isInitialized) ...[
            Align(
              alignment: Alignment.topCenter,
              child: CameraWidget(
                size: size,
                controller: _controller,
              ),
            ),
            Positioned(
              right: 4,
              child: EffectCameraWidget(
                controller: _controller,
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: CameraMainFunctionWidget(
                controller: _controller,
              ),
            ),
          ] else
            const LoadingWidget()
        else
          const LoadingWidget()
      ],
    );
  }
}
