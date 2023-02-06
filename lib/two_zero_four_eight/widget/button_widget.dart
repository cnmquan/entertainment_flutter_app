import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../theme/color.dart';

class ButtonWidget extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;
  const ButtonWidget({
    Key? key,
    this.text,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      //Button Widget with icon for Undo and Restart Game button.
      return Container(
        decoration: BoxDecoration(
            color: ColorManager.scoreColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: IconButton(
            color: ColorManager.textColorWhite,
            onPressed: onPressed,
            icon: Icon(
              icon,
              size: 24.0,
            )),
      );
    }
    //Button Widget with text for New Game and Try Again button.
    return ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(16.0)),
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorManager.buttonColor)),
        onPressed: onPressed,
        child: Text(
          text!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ));
  }
}

class ButtonLevelWidget extends StatelessWidget {
  final Function(int?)? onPress;
  final int level;
  const ButtonLevelWidget({
    super.key,
    this.onPress,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: LevelContentWidget(
          icon: levelIcons[level],
          isNotChoose: false,
        ),
        customItemsHeights: [
          ...List<double>.filled(levels.length, 48),
        ],
        items: [
          ...levels.map(
            (item) => DropdownMenuItem<int>(
              value: item,
              child: LevelContentWidget(
                icon: levelIcons[item],
                inList: true,
                isNotChoose: level != item,
              ),
            ),
          ),
        ],
        onChanged: onPress,
        dropdownWidth: 140,
        dropdownPadding: const EdgeInsets.symmetric(vertical: 12),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorManager.backgroundColor,
        ),
        dropdownElevation: 4,
      ),
    );
  }
}

List<IconData> levelIcons = [
  Icons.looks_3_outlined,
  Icons.looks_4_outlined,
  Icons.looks_5_outlined,
  Icons.looks_6_outlined,
];

List<int> levels = [0, 1, 2, 3];

class LevelContentWidget extends StatelessWidget {
  final IconData icon;
  final bool inList;
  final bool isNotChoose;
  const LevelContentWidget({
    Key? key,
    required this.icon,
    this.inList = false,
    this.isNotChoose = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 48,
      decoration: inList && isNotChoose
          ? null
          : BoxDecoration(
              color: ColorManager.scoreColor,
              borderRadius: BorderRadius.circular(8.0)),
      padding: inList && isNotChoose
          ? null
          : const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24.0,
              color: inList && isNotChoose
                  ? ColorManager.textColor
                  : ColorManager.textColorWhite,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              '×',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: inList && isNotChoose
                    ? ColorManager.textColor
                    : ColorManager.textColorWhite,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Icon(
              icon,
              size: 24.0,
              color: inList && isNotChoose
                  ? ColorManager.textColor
                  : ColorManager.textColorWhite,
            ),
          ],
        ),
      ),
    );
  }
}
