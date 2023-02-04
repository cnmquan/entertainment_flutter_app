import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/widget.dart';

class CameraArPage extends StatelessWidget {
  const CameraArPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: ButtonIconWidget(
          size: 20,
          iconDefault: Icons.arrow_back_ios,
          iconPress: Icons.arrow_back_ios,
          onPress: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const SafeArea(
        child: DeepArCameraWidget(),
      ),
    );
  }
}
