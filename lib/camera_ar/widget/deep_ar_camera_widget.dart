import 'dart:io';

import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/model/ar_filter_model.dart';
import 'package:flutter_camera_app/camera_ar/widget.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

import '../logic/ar_logic.dart';
import '../utils.dart';

class DeepArCameraWidget extends StatefulWidget {
  const DeepArCameraWidget({Key? key}) : super(key: key);

  @override
  State<DeepArCameraWidget> createState() => _DeepArCameraWidgetState();
}

class _DeepArCameraWidgetState extends State<DeepArCameraWidget> {
  DeepArController? _controller;
  bool _isOpenFilter = false;
  bool _isOpenMasked = false;
  bool _isOpenEffect = false;

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

  void _updateEffect(ArModel? effect) {
    if (_controller != null) {
      if (_controller!.isInitialized) {
        if (effect != null) {
          _controller!.switchEffect(effect.fileAr);
        } else {
          _controller!.switchEffect(null);
        }
      }
    }
  }

  void _updateFilter(ArModel? filter) {
    if (_controller != null) {
      if (_controller!.isInitialized) {
        if (filter != null) {
          _controller!.switchFilter(filter.fileAr);
        } else {
          _controller!.switchFilter(null);
        }
      }
    }
  }

  void _updateMasked(ArModel? masked) {
    if (_controller != null) {
      if (_controller!.isInitialized) {
        if (masked != null) {
          _controller!.switchFaceMask(masked.fileAr);
        } else {
          _controller!.switchFaceMask(null);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    DeepArLogic logic = Provider.of(context, listen: true);
    _updateEffect(logic.effect);
    _updateFilter(logic.filter);
    _updateMasked(logic.masked);
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_controller != null)
          if (_controller!.isInitialized) ...[
            DeepArPreview(_controller!),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonIconWidget(
                    size: 20,
                    iconDefault: Icons.arrow_back_ios,
                    iconPress: Icons.arrow_back_ios,
                    onPress: () {
                      Navigator.pop(context);
                    },
                  ),
                  ButtonIconWidget(
                    iconDefault: Icons.flash_off,
                    iconPress: Icons.flash_on,
                    onPress: () async {
                      await _controller!.toggleFlash();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_isOpenEffect) ...[
                    const SelectionEffectWidget(),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                  if (_isOpenFilter) ...[
                    const SelectionFilterWidget(),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                  if (_isOpenMasked) ...[
                    const SelectionMaskedWidget(),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          color: _isOpenFilter
                              ? Colors.pinkAccent.withOpacity(0.2)
                              : Colors.transparent,
                          child: SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ButtonIconWidget(
                                  iconDefault: Icons.filter_hdr_outlined,
                                  iconPress: Icons.filter_hdr_outlined,
                                  onPress: () async {
                                    if (_isOpenFilter) {
                                      _isOpenFilter = false;
                                    } else {
                                      _isOpenMasked = false;
                                      _isOpenEffect = false;
                                      _isOpenFilter = true;
                                    }
                                    setState(() {});
                                  },
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  'Filter',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          color: _isOpenEffect
                              ? Colors.lightGreenAccent.withOpacity(0.2)
                              : Colors.transparent,
                          child: SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ButtonIconWidget(
                                  iconDefault: Icons.colorize,
                                  iconPress: Icons.colorize,
                                  onPress: () async {
                                    if (_isOpenEffect) {
                                      _isOpenEffect = false;
                                    } else {
                                      _isOpenMasked = false;
                                      _isOpenEffect = true;
                                      _isOpenFilter = false;
                                    }
                                    setState(() {});
                                  },
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  'Effect',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Material(
                          color: _isOpenMasked
                              ? Colors.lightBlueAccent.withOpacity(0.2)
                              : Colors.transparent,
                          child: SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ButtonIconWidget(
                                  iconDefault:
                                      Icons.face_retouching_natural_rounded,
                                  iconPress:
                                      Icons.face_retouching_natural_rounded,
                                  onPress: () async {
                                    if (_isOpenMasked) {
                                      _isOpenMasked = false;
                                    } else {
                                      _isOpenMasked = true;
                                      _isOpenEffect = false;
                                      _isOpenFilter = false;
                                    }
                                    setState(() {});
                                  },
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  'Masked',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ButtonIconWidget(
                        iconDefault: Icons.videocam_outlined,
                        iconPress: Icons.videocam_sharp,
                        size: 60,
                        onPress: () async {
                          if (_controller!.isRecording) {
                            File? file =
                                await _controller!.stopVideoRecording();
                            OpenFile.open(file.path);
                          } else {
                            await _controller!.startVideoRecording();
                          }

                          setState(() {});
                        },
                      ),
                      ButtonIconWidget(
                        iconDefault: Icons.photo_camera,
                        iconPress: Icons.photo_camera,
                        size: 60,
                        onPress: () {
                          _controller!.takeScreenshot().then((file) {
                            OpenFile.open(file.path);
                          });
                        },
                      ),
                      ButtonIconWidget(
                        iconDefault: Icons.cameraswitch,
                        iconPress: Icons.cameraswitch_outlined,
                        onPress: () {
                          _controller!.flipCamera();
                        },
                      ),
                    ],
                  ),
                ],
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
