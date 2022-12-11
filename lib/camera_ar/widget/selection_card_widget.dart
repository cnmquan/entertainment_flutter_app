import 'package:flutter/material.dart';

class SelectionCardWidget extends StatelessWidget {
  final String assetName;
  final String name;
  final VoidCallback? onPress;
  final double size;
  final double padding;
  final bool selected;
  const SelectionCardWidget({
    Key? key,
    required this.assetName,
    required this.name,
    this.onPress,
    this.size = 80,
    this.padding = 16,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Material(
          color: selected ? Colors.white.withOpacity(0.4) : Colors.transparent,
          child: InkWell(
            onTap: onPress,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
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
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
