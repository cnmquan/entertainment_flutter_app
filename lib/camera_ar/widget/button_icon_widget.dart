import 'package:flutter/material.dart';

class ButtonIconWidget extends StatefulWidget {
  final IconData iconDefault;
  final IconData iconPress;
  final VoidCallback? onPress;
  final double size;

  const ButtonIconWidget({
    Key? key,
    this.onPress,
    required this.iconDefault,
    required this.iconPress,
    this.size = 40,
  }) : super(key: key);

  @override
  State<ButtonIconWidget> createState() => _ButtonIconWidgetState();
}

class _ButtonIconWidgetState extends State<ButtonIconWidget> {
  int _currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: widget.size,
      icon: _currIndex == 0
          ? Icon(
              widget.iconDefault,
              key: const ValueKey('icon1'),
              color: Colors.white,
            )
          : Icon(
              widget.iconPress,
              key: const ValueKey('icon2'),
              color: Colors.white,
            ),
      onPressed: () {
        widget.onPress?.call();
        setState(() {
          _currIndex = _currIndex == 0 ? 1 : 0;
        });
      },
    );
  }
}
