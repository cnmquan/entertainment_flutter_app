import 'package:flutter/material.dart';

import '../model/model.dart';

class AnimatedTileWidget extends AnimatedWidget {
  AnimatedTileWidget({
    super.key,
    required this.tile,
    required this.child,
    required this.moveAnimation,
    required this.scaleAnimation,
    required this.size,
    this.squareSize = 4,
    this.padding = 12,
  }) : super(listenable: Listenable.merge([moveAnimation, scaleAnimation]));

  final TileModel tile;
  final Widget child;
  final CurvedAnimation moveAnimation;
  final CurvedAnimation scaleAnimation;
  final double size;
  final int squareSize;
  final double padding;

  late final double _top = tile.getTop(
    size: size,
    squareSize: squareSize,
    padding: padding,
  );
  late final double _left = tile.getLeft(
    size: size,
    squareSize: squareSize,
    padding: padding,
  );
  late final double _nextTop = tile.getNextTop(
        size: size,
        squareSize: squareSize,
        padding: padding,
      ) ??
      _top;
  late final double _nextLeft = tile.getNextLeft(
        size: size,
        squareSize: squareSize,
        padding: padding,
      ) ??
      _left;

  late final Animation<double> moveTop =
      Tween<double>(begin: _top, end: _nextTop).animate(moveAnimation);
  late final Animation<double> moveLeft =
      Tween<double>(begin: _left, end: _nextLeft).animate(moveAnimation);
  late final Animation<double> scale =
      TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1, end: 1.5)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.5, end: 1)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50),
  ]).animate(scaleAnimation);
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: moveTop.value,
      left: moveLeft.value,
      child: tile.merged == true
          ? ScaleTransition(
              scale: scale,
              child: child,
            )
          : child,
    );
  }
}
