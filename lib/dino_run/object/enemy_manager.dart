import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter_camera_app/dino_run/logic/dino_game.dart';
import 'package:flutter_camera_app/dino_run/utils.dart';

import '../model.dart';
import '../object.dart';

class EnemyManager extends Component with HasGameRef<DinoGame> {
  // A list to hold data for all the enemies.
  final List<EnemyData> _data = [];

  // Random generator required for randomly selecting enemy type.
  final Random _random = Random();

  // Timer to decide when to spawn next enemy.
  final Timer _timer = Timer(2, repeat: true);

  int level = 1;

  EnemyManager() {
    _timer.onTick = () {
      spawnRandomEnemy.call();
      if (level > 1) {
        spawnRandomEnemy.call();
      }
    };
  }

  void spawnRandomEnemy() {
    /// Generate a random index within [_data] and get an [EnemyData].
    final randomIndex = _random.nextInt(_data.length);
    final enemyData = _data.elementAt(randomIndex);
    final enemy = Enemy(enemyData);

    // Help in setting all enemies on ground.
    enemy.anchor = Anchor.bottomLeft;
    enemy.position = Vector2(
      enemyData.isReverse ? 0 : (gameRef.size.x + 32),
      gameRef.size.y - 24,
    );

    // If this enemy can fly, set its y position randomly.
    if (enemyData.canFly) {
      final newHeight = _random.nextDouble() * 2 * enemyData.textureSize.y;
      enemy.position.y -= newHeight;
    }

    // Due to the size of our viewport, we can
    // use textureSize as size for the components.
    enemy.size = enemyData.textureSize;
    gameRef.add(enemy);
  }

  @override
  void onMount() {
    level = gameRef.settingData.level ?? 1;
    if (isMounted) {
      removeFromParent();
    }

    // Don't fill list again and again on every mount.
    if (_data.isEmpty) {
      // As soon as this component is mounted, initialize all the data.
      _data.addAll([
        if (level > 0) ...[
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyAngryPig),
            nFrames: 16,
            stepTime: 0.1,
            textureSize: Vector2(36, 30),
            speedX: 80 + (level - 1) * 10,
            canFly: false,
            canKick: level < 3,
          ),
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyBat),
            nFrames: 7,
            stepTime: 0.1,
            textureSize: Vector2(46, 30),
            speedX: 100 + (level - 1) * 20,
            canFly: true,
            canKick: level < 3,
          ),
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyRino),
            nFrames: 6,
            stepTime: 0.09,
            textureSize: Vector2(52, 34),
            speedX: 150 + (level - 1) * 20,
            canFly: false,
            canKick: level < 3,
          ),
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyChicken),
            nFrames: 14,
            stepTime: 0.1,
            textureSize: Vector2(32, 34),
            speedX: 100 + (level - 1) * 20,
            canFly: false,
            canKick: level < 3,
          ),
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemySnail),
            nFrames: 10,
            stepTime: 0.12,
            textureSize: Vector2(38, 24),
            speedX: 50 + (level - 1) * 10,
            canFly: false,
            canKick: level < 3,
          ),
        ],
        if (level > 1) ...[
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyPinkMan),
            nFrames: 12,
            stepTime: 0.08,
            textureSize: Vector2(32, 32),
            speedX: 180 + (level - 1) * 10,
            canFly: false,
            canKick: level < 2,
            isReverse: true,
          ),
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyVirtualGuy),
            nFrames: 12,
            stepTime: 0.08,
            textureSize: Vector2(32, 32),
            speedX: 160 + (level - 1) * 10,
            canFly: false,
            canKick: level < 2,
            isReverse: true,
          ),
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyBird),
            nFrames: 9,
            stepTime: 0.1,
            textureSize: Vector2(32, 32),
            speedX: 100 + (level - 1) * 20,
            canFly: true,
            canKick: level < 3,
          ),
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyBunny),
            nFrames: 12,
            stepTime: 0.08,
            textureSize: Vector2(34, 44),
            speedX: 140 + (level - 1) * 20,
            canFly: false,
            canKick: level < 3,
          ),
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyRandish),
            nFrames: 12,
            stepTime: 0.12,
            textureSize: Vector2(30, 38),
            speedX: 60 + (level - 1) * 20,
            canFly: false,
            canKick: level < 3,
          ),
        ],
        if (level > 2) ...[
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyMaskedDude),
            nFrames: 12,
            stepTime: 0.12,
            textureSize: Vector2(32, 32),
            speedX: 100 + (level - 1) * 10,
            canFly: false,
            canKick: level < 2,
            isReverse: true,
          ),
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyNinjaFrog),
            nFrames: 12,
            stepTime: 0.06,
            textureSize: Vector2(32, 32),
            speedX: 180 + (level - 1) * 10,
            canFly: false,
            canKick: level < 2,
            isReverse: true,
          ),
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyGhost),
            nFrames: 10,
            stepTime: 0.12,
            textureSize: Vector2(44, 30),
            speedX: 60 + (level - 1) * 20,
            canFly: true,
            canKick: level < 3,
          ),
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemySlime),
            nFrames: 10,
            stepTime: 0.12,
            textureSize: Vector2(44, 30),
            speedX: 40 + (level - 1) * 10,
            canFly: false,
            canKick: level < 3,
          ),
          EnemyData(
            image: gameRef.images.fromCache(ImageManager.enemyTrunk),
            nFrames: 14,
            stepTime: 0.1,
            textureSize: Vector2(64, 32),
            speedX: 60 + (level - 1) * 20,
            canFly: false,
            canKick: level < 3,
          ),
        ]
      ]);
    }
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllEnemies() {
    final enemies = gameRef.children.whereType<Enemy>();
    for (var enemy in enemies) {
      enemy.removeFromParent();
    }
  }
}
