import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_camera_app/dino_run/logic/dino_game.dart';
import 'package:flutter_camera_app/dino_run/object.dart';

import '../model.dart';

class Enemy extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<DinoGame> {
  // The data required for creation of this enemy.
  final EnemyData enemyData;

  int gravity = 0;

  Enemy(this.enemyData) {
    animation = SpriteAnimation.fromFrameData(
      enemyData.image,
      SpriteAnimationData.sequenced(
        amount: enemyData.nFrames,
        stepTime: enemyData.stepTime,
        textureSize: enemyData.textureSize,
      ),
    );
  }

  @override
  void onMount() {
    // Reduce the size of enemy as they look too
    // big compared to the dino.
    size *= 0.6;
    // Add a hitbox for this enemy.
    add(
      RectangleHitbox.relative(
        Vector2.all(0.8),
        parentSize: size,
        position: Vector2(size.x * 0.2, size.y * 0.2) / 2,
      ),
    );
    super.onMount();
  }

  @override
  void update(double dt) {
    position.x =
        position.x + (enemyData.isReverse ? 1 : -1) * enemyData.speedX * dt;

    position.y += gravity * dt;

    // Remove the enemy and increase player score
    // by 1, if enemy has gone past left end of the screen.
    if (position.x < -enemyData.textureSize.x && !enemyData.isReverse) {
      removeFromParent();
      gameRef.playerData.currentScore += 1;
    }

    if (position.x > gameRef.size.x + enemyData.textureSize.x &&
        enemyData.isReverse) {
      removeFromParent();
      gameRef.playerData.currentScore += 1;
    }

    if (position.y > gameRef.size.y) {
      removeFromParent();
      gameRef.playerData.currentScore += 2;
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      if (!enemyData.canKick) {
        return super.onCollision(intersectionPoints, other);
      }
      if (other.position.y < position.y || other.isKick) {
        defeat();
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  void defeat() {
    gravity = 100;
  }
}
