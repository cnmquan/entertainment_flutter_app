import 'package:flame/extensions.dart';

class EnemyData {
  final Image image;
  final int nFrames;
  final double stepTime;
  final Vector2 textureSize;
  final double speedX;
  final bool canFly;
  final bool canKick;
  final bool isReverse;

  const EnemyData({
    required this.image,
    required this.nFrames,
    required this.stepTime,
    required this.textureSize,
    required this.speedX,
    required this.canFly,
    required this.canKick,
    this.isReverse = false,
  });
}
