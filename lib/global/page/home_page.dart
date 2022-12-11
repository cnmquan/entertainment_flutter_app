import 'package:flutter/material.dart';
import 'package:flutter_camera_app/global/widget.dart';
import 'package:flutter_camera_app/utils/constants/global_constants.dart';

import '../../camera_ar/page/camera_ar_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(GlobalConstants.homePage),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BoxWidget(
              text: GlobalConstants.arCamera,
              height: 240,
              onPress: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CameraArPage()))
              },
            ),
            BoxWidget(
              text: GlobalConstants.dinoGame,
              height: 240,
              onPress: () => {},
            )
          ],
        ),
      ),
    );
  }
}
