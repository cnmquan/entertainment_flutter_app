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
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
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
                  ElevatedButton(
                    onPressed: () {
                      gameRef.startGamePlay();
                      gameRef.overlays.remove(MainMenuWidget.id);
                      gameRef.overlays.add(HudWidget.id);
                    },
                    child: const Text(
                      TranslateManager.playText,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(MainMenuWidget.id);
                      gameRef.overlays.add(SettingsWidget.id);
                    },
                    child: const Text(
                      TranslateManager.settingsText,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
