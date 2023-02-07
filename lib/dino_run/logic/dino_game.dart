import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../model.dart';
import '../object.dart';
import '../utils.dart';
import '../widget.dart';

class DinoGame extends FlameGame
    with
        TapDetector,
        HasCollisionDetection,
        HorizontalDragDetector,
        VerticalDragDetector {
  late PlayerData playerData;
  late SettingData settingData;
  late Player _player;
  late EnemyManager _enemyManager;
  @override
  Future<void> onLoad() async {
    playerData = await FunctionManager.readPlayerData();
    settingData = await FunctionManager.readSettings();

    /// Initialize [AudioManager].
    await AudioManager.instance.init(audioList, settingData);

    // Start playing background music. Internally takes care
    // of checking user settings.
    AudioManager.instance.startBgm(SoundManager.audio8BitPlatform);

    // Cache all the images.
    await images.loadAll(imageList);

    // Set a fixed viewport to avoid manually scaling
    // and handling different screen sizes.
    camera.viewport = FixedResolutionViewport(Vector2(360, 180));

    /// Create a [ParallaxComponent] and add it to game.
    final parallaxBackground = await loadParallaxComponent(
      [
        ParallaxImageData(ImageManager.parallax1),
        ParallaxImageData(ImageManager.parallax2),
        ParallaxImageData(ImageManager.parallax3),
        ParallaxImageData(ImageManager.parallax4),
        ParallaxImageData(ImageManager.parallax5),
        ParallaxImageData(ImageManager.parallax6),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.4, 0),
    );
    add(parallaxBackground);

    return super.onLoad();
  }

  /// This method add the already created [Dino]
  /// and [EnemyManager] to this game.
  void startGamePlay() {
    _player = Player(
        images.fromCache(playerImageList[settingData.form ?? 0]), playerData);
    _enemyManager = EnemyManager();

    add(_player);
    add(_enemyManager);
  }

  // This method remove all the actors from the game.
  void _disconnectActors() {
    _player.removeFromParent();
    _enemyManager.removeAllEnemies();
    _enemyManager.removeFromParent();
  }

  // This method reset the whole game world to initial state.
  void reset() {
    // First disconnect all actions from game world.
    _disconnectActors();

    // Reset player data to initial values.
    playerData.currentScore = 0;
    playerData.lives = 6 - (settingData.level ?? 1);
  }

  @override
  void update(double dt) {
    // If number of lives is 0 or less, game is over.
    if (playerData.lives <= 0) {
      overlays.add(GameOverWidget.id);
      overlays.remove(HudWidget.id);
      pauseEngine();
      AudioManager.instance.pauseBgm();
    }

    super.update(dt);
  }

  @override
  void onVerticalDragStart(DragStartInfo info) {
    Logger().i('Call Drag Vertical Start');
    if (overlays.isActive(HudWidget.id)) {
      _player.jump();
    }
    super.onVerticalDragStart(info);
  }

  @override
  void onHorizontalDragStart(DragStartInfo info) {
    Logger().i('Call Drag Horizontal Start');
    if (overlays.isActive(HudWidget.id)) {
      _player.sprint();
    }
    super.onHorizontalDragStart(info);
  }

  @override
  void onHorizontalDragEnd(DragEndInfo info) {
    Logger().i('Call Drag Horizontal End');
    if (overlays.isActive(HudWidget.id)) {
      _player.run();
    }
    super.onHorizontalDragEnd(info);
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (overlays.isActive(HudWidget.id)) {
      _player.kick();
    }
    super.onTapDown(info);
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // On resume, if active overlay is not PauseMenu,
        // resume the engine (lets the parallax effect play).
        if (!(overlays.isActive(PauseMenuWidget.id)) &&
            !(overlays.isActive(GameOverWidget.id))) {
          resumeEngine();
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        // If game is active, then remove Hud and add PauseMenu
        // before pausing the game.
        if (overlays.isActive(HudWidget.id)) {
          overlays.remove(HudWidget.id);
          overlays.add(PauseMenuWidget.id);
        }
        pauseEngine();
        break;
    }
    super.lifecycleStateChange(state);
  }
}
