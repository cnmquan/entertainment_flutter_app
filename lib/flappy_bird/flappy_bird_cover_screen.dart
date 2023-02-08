import 'package:flutter/material.dart';

class FlappyBirdCoverScreen extends StatelessWidget {
  const FlappyBirdCoverScreen({
    super.key,
    required this.gameHasStarted,
  });

  final bool gameHasStarted;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.5),
      child: Text(
        gameHasStarted ? "" : "TAP TO PLAY",
        style: const TextStyle(
          color: Colors.white,
          fontFamily: r'Audiowide',
          letterSpacing: 5,
          wordSpacing: 8,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
