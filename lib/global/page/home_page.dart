import 'package:flutter/material.dart';
// import 'package:flutter_camera_app/2048/page/game_2048_page.dart';
import 'package:flutter_camera_app/dino_run/page/dino_home_page.dart';
import 'package:flutter_camera_app/flappy_bird/flappy_bird_home_page.dart';
import 'package:flutter_camera_app/global/logic/secret_controller.dart';
import 'package:flutter_camera_app/global/page/fool_page.dart';
import 'package:flutter_camera_app/global/widget.dart';
import 'package:flutter_camera_app/spacescape/screens/spacescape_main_menu.dart';
import 'package:flutter_camera_app/two_zero_four_eight/page/game_two_zero_four_eight_page.dart';
import 'package:flutter_camera_app/utils/constants/global_constants.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../camera_ar/page/camera_ar_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secret = Provider.of<SecretController>(context);
    // secret.isAnswer = false;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          GlobalConstants.homePage,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          if (!secret.isAnswer) ...[
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Text(
                                    'Mini Guest',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: r'Audiowide',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  const Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: 'Hint: ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                            fontFamily: r'Audiowide',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              'There are some secret number in this page. Find out and unlock new feature.',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                            fontFamily: r'Audiowide',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  OTPTextField(
                                    length: 4,
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    fieldWidth: 48,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontFamily: r'Audiowide',
                                    ),
                                    textFieldAlignment:
                                        MainAxisAlignment.spaceAround,
                                    fieldStyle: FieldStyle.box,
                                    onCompleted: (pin) {
                                      if (pin == '3202') {
                                        secret.isAnswer = true;
                                        secret.isClicked = true;
                                        Navigator.of(context).maybePop();
                                      } else {
                                        secret.isClicked = true;
                                        Navigator.of(context).maybePop();
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 36,
                                  ),
                                  const Text.rich(
                                    TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: 'PS: ',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: r'Audiowide',
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Good luck!',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: r'Audiowide',
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Just 4 number only! ',
                                          style: TextStyle(
                                            fontSize: 6,
                                            color: Colors.black26,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: r'Audiowide',
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.lock_outline,
                  size: 24,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (secret.isAnswer) ...[
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
            ] else ...[
              if (secret.isClicked) ...[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BoxWidget(
                    assetPath: r"https://source.unsplash.com/featured/300x201",
                    text: GlobalConstants.arCamera,
                    height: 240,
                    onPress: () {
                      secret.isClicked = false;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const FoolPage(),
                        ),
                      );
                    },
                  ),
                ),
              ]
            ],
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BoxWidget(
                assetPath: GlobalImageManager.dinoRunAsset,
                text: GlobalConstants.dinoGame,
                height: 240,
                secretText: '2',
                onPress: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DinoHomePage()))
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BoxWidget(
                assetPath: GlobalImageManager.game2048Asset,
                text: GlobalConstants.game2048,
                height: 240,
                secretText: '3',
                onPress: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Game2048HomePage()))
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BoxWidget(
                assetPath: GlobalImageManager.gameSpacescapeAsset,
                text: GlobalConstants.spacescapeGame,
                height: 240,
                secretText: '0',
                onPress: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SpacescapeMainMenu()))
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BoxWidget(
                assetPath: GlobalImageManager.gameFlappyBirdAsset,
                text: GlobalConstants.flappyBirdGame,
                height: 240,
                secretText: '2',
                onPress: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FlappyBirdHomePage()))
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
