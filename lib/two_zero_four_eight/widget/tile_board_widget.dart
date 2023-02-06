import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_camera_app/two_zero_four_eight/logic/game_manager.dart';
import r'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/color.dart';
import 'widget.dart';

class TileBoardWidget extends ConsumerWidget {
  final CurvedAnimation moveAnimation;
  final CurvedAnimation scaleAnimation;
  const TileBoardWidget({
    Key? key,
    required this.moveAnimation,
    required this.scaleAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardModel = ref.watch(game2048Manager);
    int squareSize = boardModel.squareSize;
    final screenSize = MediaQuery.of(context).size;
    final sizeAdjustment = max(
        290.0, min((screenSize.shortestSide * 0.90).floorToDouble(), 460.0));
    final sizePerTile = (sizeAdjustment / squareSize).floorToDouble();
    final paddingTile = 12 * (4.0 / squareSize);
    final fontSizeTile = 24 * (4.0 / squareSize);
    final tileSize = sizePerTile - paddingTile - (paddingTile / squareSize);
    final boardSize = sizePerTile * squareSize;
    return SizedBox(
      width: boardSize,
      height: boardSize,
      child: Stack(children: [
        ...List.generate(
          boardModel.tiles.length,
          (index) {
            var boardTile = boardModel.tiles[index];
            int valueLength = boardTile.value.toString().length;
            var fontSizeBaseLength =
                fontSizeTile * (1 - (valueLength - 3) * 0.03);
            return AnimatedTileWidget(
              key: ValueKey(boardTile.id),
              tile: boardTile,
              moveAnimation: moveAnimation,
              scaleAnimation: scaleAnimation,
              size: tileSize,
              squareSize: squareSize,
              padding: paddingTile,
              child: Container(
                width: tileSize,
                height: tileSize,
                decoration: BoxDecoration(
                  color: ColorManager.tileColors.containsKey(boardTile.value)
                      ? ColorManager.tileColors[boardTile.value]
                      : Colors.black54,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    '${boardTile.value}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: fontSizeBaseLength,
                      letterSpacing:
                          valueLength > 5 && valueLength < 10 ? 2 : 1,
                      color: boardTile.value < 8
                          ? ColorManager.textColor
                          : ColorManager.textColorWhite,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        if (boardModel.gameOver) ...[
          Positioned.fill(
              child: Material(
            color: ColorManager.overlayColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  boardModel.gameWon ? 'You win!' : 'Game over!',
                  style: const TextStyle(
                    color: ColorManager.textColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    fontSize: 64,
                  ),
                  textAlign: TextAlign.center,
                ),
                ButtonWidget(
                  text: boardModel.gameWon ? 'New Game' : 'Try again',
                  onPressed: () {
                    ref.read(game2048Manager.notifier).newGame(squareSize);
                  },
                )
              ],
            ),
          )),
        ]
      ]),
    );
  }
}
