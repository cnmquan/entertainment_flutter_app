import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../logic/dino_game.dart';
import '../widget.dart';

class DinoHomePage extends StatefulWidget {
  const DinoHomePage({Key? key}) : super(key: key);

  @override
  State<DinoHomePage> createState() => _DinoHomePageState();
}

class _DinoHomePageState extends State<DinoHomePage> {
  final DinoGame _game = DinoGame();
  @override
  void initState() {
    Flame.device.setLandscape();
    super.initState();
  }

  @override
  void dispose() {
    Flame.device.setPortrait();
    FlameAudio.bgm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: r'Audiowide',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Settings up some default theme for elevated buttons.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            fixedSize: const Size(200, 60),
          ),
        ),
      ),
      child: Scaffold(
        body: GameWidget(
          // This will display a loading bar until [DinoRun] completes
          // its onLoad method.
          loadingBuilder: (context) => const Center(
            child: SizedBox(
              width: 200,
              child: LinearProgressIndicator(),
            ),
          ),
          // Register all the overlays that will be used by this game.
          overlayBuilderMap: {
            MainMenuWidget.id: (_, DinoGame gameRef) => MainMenuWidget(gameRef),
            PauseMenuWidget.id: (_, DinoGame gameRef) =>
                PauseMenuWidget(gameRef),
            HudWidget.id: (_, DinoGame gameRef) => HudWidget(gameRef),
            GameOverWidget.id: (_, DinoGame gameRef) => GameOverWidget(gameRef),
            SettingsWidget.id: (_, DinoGame gameRef) => SettingsWidget(gameRef),
          },
          // By default MainMenu overlay will be active.
          initialActiveOverlays: const [MainMenuWidget.id],
          game: _game,
        ),
      ),
    );
  }
}
