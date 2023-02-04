import 'package:flutter/material.dart';

class SelectionCardWidget extends StatelessWidget {
  final String assetName;
  final String name;
  final VoidCallback? onPress;
  final double size;
  final bool selected;
  const SelectionCardWidget({
    Key? key,
    required this.assetName,
    required this.name,
    this.onPress,
    this.size = 100,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white30, width: selected ? 0 : 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Material(
          color: selected ? Colors.white.withOpacity(0.4) : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: onPress,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      assetName,
                      fit: BoxFit.fitHeight,
                      width: size,
                      height: size,
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
