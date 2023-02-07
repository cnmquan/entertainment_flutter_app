import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_camera_app/dino_run/utils.dart';
import 'package:provider/provider.dart';

import '../logic/dino_game.dart';
import '../model.dart';
import '../widget.dart';

// This represents the game over overlay,
// displayed with dino runs out of lives.
class GameOverWidget extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = ConstantManager.gameOverWidgetId;

  // Reference to parent game.
  final DinoGame gameRef;

  const GameOverWidget(this.gameRef, {super.key});

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
                    const Text(
                      TranslateManager.gameOverText,
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    Selector<PlayerData, int>(
                      selector: (_, playerData) => playerData.currentScore,
                      builder: (_, score, __) {
                        return Text(
                          '${TranslateManager.yourScoreText}: $score',
                          style: const TextStyle(
                              fontSize: 40, color: Colors.white),
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white30,
                      ),
                      onPressed: () {
                        gameRef.overlays.remove(GameOverWidget.id);
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white30,
                      ),
                      onPressed: () {
                        gameRef.overlays.remove(GameOverWidget.id);
                        gameRef.overlays.add(MainMenuWidget.id);
                        gameRef.resumeEngine();
                        gameRef.reset();
                        AudioManager.instance.resumeBgm();
                      },
                      child: const Text(
                        TranslateManager.backText,
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
