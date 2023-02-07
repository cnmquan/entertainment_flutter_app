import 'dart:ui';

import 'package:flutter/material.dart';

import '../logic/dino_game.dart';
import '../utils.dart';
import '../widget.dart';

// This represents the main menu overlay.
class MainMenuWidget extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = ConstantManager.mainMenuWidgetId;

  // Reference to parent game.
  final DinoGame gameRef;

  const MainMenuWidget(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black.withAlpha(100),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  children: [
                    const Text(
                      TranslateManager.dinoGameText,
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          gameRef.overlays.remove(MainMenuWidget.id);
                          gameRef.overlays.add(PlayerFormWidget.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white30,
                        ),
                        child: const Text(
                          TranslateManager.startText,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          gameRef.overlays.remove(MainMenuWidget.id);
                          gameRef.overlays.add(SettingsWidget.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white30,
                        ),
                        child: const Text(
                          TranslateManager.settingsText,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white30,
                        ),
                        child: const Text(
                          TranslateManager.exitText,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
