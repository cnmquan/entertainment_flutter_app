import 'package:flutter/material.dart';
import 'package:flutter_camera_app/two_zero_four_eight/theme/color.dart';

class ScorePointWidget extends StatelessWidget {
  final String label;
  final String score;
  final EdgeInsets? padding;
  const ScorePointWidget({
    Key? key,
    required this.label,
    required this.score,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
          color: ColorManager.scoreColor,
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            color: ColorManager.color2,
            letterSpacing: 2,
          ),
        ),
        Text(
          score,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
        )
      ]),
    );
  }
}
