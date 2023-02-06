import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final double barrierWidth; // out of 2, where 2 is the width of the screen
  final double barrierHeight;
  final double barrierX;
  final bool isThisBottomBarBarrier;
  const MyBarrier(
      {super.key,
      required this.barrierWidth,
      required this.barrierHeight,
      required this.barrierX,
      required this.isThisBottomBarBarrier});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isThisBottomBarBarrier ? 1 : -1),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                isThisBottomBarBarrier
                    ? 'assets/images/flappy_bird/pipe-red.png'
                    : 'assets/images/flappy_bird/pipe-red-rotated.png',
              ),
              fit: BoxFit.fill),
        ),
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
      ),
    );
  }
}
