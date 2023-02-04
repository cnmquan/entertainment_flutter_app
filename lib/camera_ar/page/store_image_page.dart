import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/page/camera_ar_page.dart';

import '../widget.dart';

class StoreImagePage extends StatelessWidget {
  const StoreImagePage({Key? key}) : super(key: key);

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CameraArPage(),
              ),
            );
          },
        ),
        title: const Text(
          r'Kho lưu trữ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: const SizedBox(),
    );
  }
}
