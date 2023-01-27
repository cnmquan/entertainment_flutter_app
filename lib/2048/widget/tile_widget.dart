import 'package:flutter/material.dart';
import 'package:flutter_camera_app/2048/theme/color.dart';

class TileWidget extends StatefulWidget {
  final String number;
  final double width, height, size;
  final Color color;

  const TileWidget({
    super.key,
    required this.number,
    required this.width,
    required this.height,
    required this.color,
    required this.size,
  });

  @override
  State<StatefulWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Center(
        child: Text(
          widget.number,
          style: TextStyle(
            fontSize: widget.size,
            fontWeight: FontWeight.bold,
            color: ColorTheme.fontColorTwoFour,
          ),
        ),
      ),
    );
  }
}
