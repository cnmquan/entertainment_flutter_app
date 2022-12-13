import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/dino_game.dart';
import '../model.dart';
import '../utils.dart';
import '../widget.dart';

// This represents the pause menu overlay.
class PauseMenuWidget extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = ConstantManager.pauseMenuWidgetId;

  // Reference to parent game.
  final DinoGame gameRef;

  const PauseMenuWidget(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: gameRef.playerData,
      child: Center(
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
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Selector<PlayerData, int>(
                        selector: (_, playerData) => playerData.currentScore,
                        builder: (_, score, __) {
                          return Text(
                            '${TranslateManager.scoreText}: $score',
                            style: const TextStyle(
                                fontSize: 40, color: Colors.white),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        gameRef.overlays.remove(PauseMenuWidget.id);
                        gameRef.overlays.add(HudWidget.id);
                        gameRef.resumeEngine();
                        AudioManager.instance.resumeBgm();
                      },
                      child: const Text(
                        TranslateManager.resumeText,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        gameRef.overlays.remove(PauseMenuWidget.id);
                        gameRef.overlays.add(HudWidget.id);
                        gameRef.resumeEngine();
                        gameRef.reset();
                        gameRef.startGamePlay();
                        AudioManager.instance.resumeBgm();
                      },
                      child: const Text(
                        TranslateManager.restartText,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        gameRef.overlays.remove(PauseMenuWidget.id);
                        gameRef.overlays.add(MainMenuWidget.id);
                        gameRef.resumeEngine();
                        gameRef.reset();
                        AudioManager.instance.resumeBgm();
                      },
                      child: const Text(
                        TranslateManager.exitText,
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
      ),
    );
  }
}
