import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_camera_app/dino_run/logic/dino_game.dart';
import 'package:flutter_camera_app/dino_run/utils.dart';

import '../model.dart';
import '../object.dart';

/// This enum represents the animation states of [Player].
enum PlayerAnimationStates {
  idle,
  run,
  kick,
  hit,
  sprint,
}

class Player extends SpriteAnimationGroupComponent<PlayerAnimationStates>
    with CollisionCallbacks, HasGameRef<DinoGame> {
  // A map of all the animation states and their corresponding animations.
  static final _animationMap = {
    PlayerAnimationStates.idle: SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
    ),
    PlayerAnimationStates.run: SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4) * 24, 0),
    ),
    PlayerAnimationStates.kick: SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4 + 6) * 24, 0),
    ),
    PlayerAnimationStates.hit: SpriteAnimationData.sequenced(
      amount: 3,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4 + 6 + 4) * 24, 0),
    ),
    PlayerAnimationStates.sprint: SpriteAnimationData.sequenced(
      amount: 7,
      stepTime: 0.1,
      textureSize: Vector2.all(24),
      texturePosition: Vector2((4 + 6 + 4 + 3) * 24, 0),
    ),
  };

  // The max distance from top of the screen beyond which
  // dino should never go. Basically the screen height - ground height
  double yMax = 0.0;
  double yMin = 0.0;
  double xMax = 0.0;
  double xMin = 0.0;

  // Dino's current speed along y-axis.
  double speedY = 0.0;
  double speedX = 0.0;

  // Controls how long the hit animations will be played.
  final Timer _hitTimer = Timer(1);
  final Timer _kickTime = Timer(1);

  static const double gravity = 800;
  static const double limit = -1;

  final PlayerData playerData;

  bool isHit = false;
  bool isKick = false;
  int level = 1;

  Player(Image image, this.playerData)
      : super.fromFrameData(image, _animationMap);

  @override
  void onMount() {
    // First reset all the important properties, because onMount()
    // will be called even while restarting the game.
    _reset();

    // Add a hitbox for dino.
    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.7),
        parentSize: size,
        position: Vector2(size.x * 0.5, size.y * 0.3) / 2,
      ),
    );
    position = Vector2(
      gameRef.size.x / 2 - size.x,
      gameRef.size.y - 24,
    );
    yMax = y;
    yMin = gameRef.size.y > 50 ? 50 : 0;
    xMin = x;
    xMax = gameRef.size.x - 96;

    /// Set the callback for [_hitTimer].
    _hitTimer.onTick = () {
      current = PlayerAnimationStates.run;
      isHit = false;
    };
    _kickTime.onTick = () {
      isKick = false;
      current = PlayerAnimationStates.run;
    };

    level = gameRef.settingData.level ?? 1;
    super.onMount();
  }

  @override
  void update(double dt) {
    // v = u + at
    speedY += gravity * dt;

    // d = s0 + s * t
    y += speedY * dt;

    speedX += limit * dt;
    x += speedX * dt;

    /// This code makes sure that dino never goes beyond [yMax].
    if (isOnGround) {
      y = yMax;
      speedY = 0.0;
      if ((current != PlayerAnimationStates.hit) &&
          (current != PlayerAnimationStates.run) &&
          (current != PlayerAnimationStates.sprint) &&
          (current != PlayerAnimationStates.kick)) {
        current = PlayerAnimationStates.run;
      }
    }

    if (isHitTop) {
      y = yMin;
      speedY = 0.0;
      if ((current != PlayerAnimationStates.hit) &&
          (current != PlayerAnimationStates.run)) {
        current = PlayerAnimationStates.run;
      }
    }

    if (isHitRight) {
      x = xMax;
      speedX = -30;
      if ((current != PlayerAnimationStates.hit) &&
          (current != PlayerAnimationStates.run) &&
          (current != PlayerAnimationStates.kick)) {
        current = PlayerAnimationStates.run;
      }
    }

    if (isHisLeft) {
      x = xMin;
      speedX = 0;
      if ((current != PlayerAnimationStates.hit) &&
          (current != PlayerAnimationStates.run) &&
          (current != PlayerAnimationStates.kick)) {
        current = PlayerAnimationStates.run;
      }
    }

    _hitTimer.update(dt);
    _kickTime.update(dt);

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // Call hit only if other component is an Enemy and dino
    // is not already in hit state.
    if ((other is Enemy) && (!isHit)) {
      if (!other.enemyData.canKick) {
        hit();
        return super.onCollision(intersectionPoints, other);
      }
      if (isKick && other.enemyData.canKick) {
        return super.onCollision(intersectionPoints, other);
      }
      if (position.y < other.position.y && level < 2) {
        return super.onCollision(intersectionPoints, other);
      }
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  // This method reset some of the important properties
  // of this component back to normal.
  void _reset() {
    if (isMounted) {
      removeFromParent();
    }
    anchor = Anchor.bottomLeft;
    position = Vector2(32, gameRef.size.y - 22);
    size = Vector2.all(24);
    current = PlayerAnimationStates.run;
    isHit = false;
    speedY = 0.0;
  }

  // Returns true if dino is on ground.
  bool get isOnGround => (y >= yMax);

  bool get isHitTop => (y <= yMin);

  bool get isCanJump => (y <= yMax && y >= yMin);

  bool get isHitRight => (x >= xMax);

  bool get isHisLeft => (x <= xMin);

  // This method changes the animation state to
  /// [PlayerAnimationStates.hit], plays the hit sound
  /// effect and reduces the player life by 1.
  void hit() {
    isHit = true;
    AudioManager.instance.playSfx(SoundManager.audioHurt);
    current = PlayerAnimationStates.hit;
    _hitTimer.start();
    playerData.lives -= 1;
  }

  // Makes the dino jump.
  void jump() {
    isKick = false;
    speedX = 0;
    if (isCanJump) {
      speedY = -300 + (level * 40);
      current = PlayerAnimationStates.idle;
      AudioManager.instance.playSfx(SoundManager.audioJump);
    }
  }

  void sprint() {
    isKick = false;
    if (isOnGround) {
      speedX = 30 / level;
      current = PlayerAnimationStates.sprint;
      AudioManager.instance.playSfx(SoundManager.audioJump);
    }
  }

  void run() {
    speedX = 0;
    isKick = false;
    current = PlayerAnimationStates.run;
    AudioManager.instance.playSfx(SoundManager.audioJump);
  }

  void kick() {
    if (isOnGround) {
      isKick = true && level < 3;
      current = PlayerAnimationStates.kick;
      AudioManager.instance.playSfx(SoundManager.audioJump);
    }
    _kickTime.start();
  }
}
