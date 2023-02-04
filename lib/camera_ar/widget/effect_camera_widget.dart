import 'package:deepar_flutter/deepar_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/ar_logic.dart';
import '../model/ar_filter_model.dart';
import '../widget.dart';

class EffectCameraWidget extends StatefulWidget {
  const EffectCameraWidget({
    super.key,
    this.controller,
  });

  final DeepArController? controller;

  @override
  State<EffectCameraWidget> createState() => _EffectCameraWidgetState();
}

class _EffectCameraWidgetState extends State<EffectCameraWidget> {
  bool _isFrontCamera = true;
  bool _turnOn = true;

  void _updateFilter(ArModel? filter) {
    if (widget.controller != null) {
      if (widget.controller!.isInitialized) {
        if (filter != null) {
          widget.controller!.switchFilter(filter.fileAr);
        } else {
          widget.controller!.switchFilter("null");
        }
      }
    }
  }

  void _updateMasked(ArModel? masked) {
    if (widget.controller != null) {
      if (widget.controller!.isInitialized) {
        if (masked != null) {
          widget.controller!.switchFaceMask(masked.fileAr);
        } else {
          widget.controller!.switchFaceMask("null");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    DeepArLogic logic = Provider.of(context, listen: true);
    if (_turnOn) {
      _updateFilter(logic.filter);
      _updateMasked(logic.masked);
    } else {
      _updateFilter(null);
      _updateMasked(null);
    }
    return SizedBox(
      width: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ButtonIconWidget(
            disable: _isFrontCamera,
            size: 32,
            iconDefault: Icons.flash_off,
            iconPress: Icons.flash_on,
            text: r'Flash',
            onPress: () {
              widget.controller?.toggleFlash();
            },
          ),
          const SizedBox(
            height: 12,
          ),
          ButtonIconWidget(
            size: 32,
            iconDefault: Icons.cameraswitch,
            iconPress: Icons.cameraswitch_outlined,
            text: r'Lật',
            onPress: () {
              widget.controller?.flipCamera().then((value) {
                setState(() {
                  _isFrontCamera = !_isFrontCamera;
                });
              });
            },
          ),
          const SizedBox(
            height: 12,
          ),
          ButtonIconWidget(
            size: 32,
            iconDefault: Icons.filter_alt_outlined,
            iconPress: Icons.filter_alt_off_outlined,
            text: r'Filter',
            onPress: () {
              setState(() {
                _turnOn = !_turnOn;
              });
            },
          ),
        ],
      ),
    );
  }
}
