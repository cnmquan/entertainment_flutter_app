import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/color.dart';

class EmptyBoardWidget extends StatelessWidget {
  final int squareSize;
  const EmptyBoardWidget({
    Key? key,
    this.squareSize = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sizeAdjustment = max(
        290.0, min((screenSize.shortestSide * 0.90).floorToDouble(), 460.0));
    final sizePerTile = (sizeAdjustment / squareSize).floorToDouble();
    final paddingTile = 12 * (4 / squareSize);
    final tileSize = sizePerTile - paddingTile - (paddingTile / squareSize);
    final boardSize = sizePerTile * squareSize;
    return Container(
      width: boardSize,
      height: boardSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: ColorManager.boardColor,
      ),
      child: Stack(
        children: List.generate(
          squareSize * squareSize,
          (index) {
            var rowId = ((index + 1) / squareSize).ceil();
            var row = rowId - 1;
            var column = index - (row * squareSize);
            var top = row * tileSize + rowId * paddingTile;
            var left = column * tileSize + (column + 1) * paddingTile;
            return Positioned(
              top: top,
              left: left,
              child: Container(
                width: tileSize,
                height: tileSize,
                decoration: BoxDecoration(
                  color: ColorManager.emptyTileColor,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
