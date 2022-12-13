import 'package:flutter/material.dart';
import 'package:flutter_camera_app/dino_run/page/dino_home_page.dart';
import 'package:flutter_camera_app/global/widget.dart';
import 'package:flutter_camera_app/utils/constants/global_constants.dart';

import '../../camera_ar/page/camera_ar_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          GlobalConstants.homePage,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BoxWidget(
                assetPath: GlobalImageManager.arIconAsset,
                text: GlobalConstants.arCamera,
                height: 240,
                onPress: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CameraArPage()))
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BoxWidget(
                assetPath: GlobalImageManager.dinoRunAsset,
                text: GlobalConstants.dinoGame,
                height: 240,
                onPress: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DinoHomePage()))
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
