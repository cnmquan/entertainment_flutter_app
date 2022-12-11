import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/logic/ar_logic.dart';
import 'package:flutter_camera_app/camera_ar/widget.dart';
import 'package:provider/provider.dart';

class CameraArPage extends StatelessWidget {
  const CameraArPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeepArLogic(),
      child: const Scaffold(
        body: SafeArea(child: DeepArCameraWidget()),
      ),
    );
  }
}
