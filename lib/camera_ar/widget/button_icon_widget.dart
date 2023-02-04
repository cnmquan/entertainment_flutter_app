import 'package:flutter/material.dart';

class ButtonIconWidget extends StatefulWidget {
  final IconData iconDefault;
  final IconData iconPress;
  final VoidCallback? onPress;
  final double size;
  final String? text;
  final bool disable;

  const ButtonIconWidget({
    Key? key,
    this.onPress,
    required this.iconDefault,
    required this.iconPress,
    this.text,
    this.size = 40,
    this.disable = false,
  }) : super(key: key);

  @override
  State<ButtonIconWidget> createState() => _ButtonIconWidgetState();
}

class _ButtonIconWidgetState extends State<ButtonIconWidget> {
  int _currIndex = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.disable
          ? null
          : () {
              widget.onPress?.call();
              setState(() {
                _currIndex = _currIndex == 0 ? 1 : 0;
              });
            },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_currIndex == 0 || widget.disable) ...[
            Icon(
              widget.iconDefault,
              key: const ValueKey('icon1'),
              color: Colors.white.withOpacity(0.9),
              size: widget.size,
            ),
          ] else ...[
            Icon(
              widget.iconPress,
              key: const ValueKey('icon2'),
              color: Colors.white.withOpacity(0.9),
              size: widget.size,
            ),
          ],
          if (widget.text != null) ...[
            const SizedBox(
              height: 4,
            ),
            Text(
              widget.text!,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
