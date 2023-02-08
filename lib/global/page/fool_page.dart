import 'package:flutter/material.dart';
import 'package:flutter_camera_app/utils/constants/global_constants.dart';

class FoolPage extends StatelessWidget {
  const FoolPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            size: 36,
            color: Colors.black26,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            GlobalImageManager.richRollAsset,
            fit: BoxFit.fill,
            width: double.maxFinite,
            height: double.maxFinite,
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
                child: Text(
              r"You've been tricked, there's nothing here.".toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 32,
                color: Colors.white24,
              ),
              textAlign: TextAlign.center,
            )),
          ),
        ],
      ),
    );
  }
}
