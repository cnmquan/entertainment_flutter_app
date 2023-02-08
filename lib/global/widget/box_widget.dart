import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BoxWidget extends StatelessWidget {
  final double? width;
  final double height;
  final String text;
  final VoidCallback? onPress;
  final String assetPath;
  final String? secretText;
  const BoxWidget({
    super.key,
    this.width,
    this.height = 240,
    required this.text,
    required this.assetPath,
    this.onPress,
    this.secretText,
  });

  @override
  Widget build(BuildContext context) {
    int left =
        Random().nextInt(MediaQuery.of(context).size.width.toInt() - 100) + 60;
    int top = Random().nextInt(height.toInt() - 100) + 60;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                image: assetPath.contains("http")
                    ? DecorationImage(
                        image: NetworkImage(assetPath),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: AssetImage(assetPath),
                        fit: BoxFit.cover,
                      ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 25,
                    spreadRadius: -5,
                  ),
                ],
                gradient: const LinearGradient(
                  colors: [Colors.white60, Colors.white10],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  width: 2,
                  color: Colors.white30,
                ),
              ),
              child: Stack(
                children: [
                  if (secretText != null) ...[
                    Positioned(
                      top: top + 0,
                      left: left + 0,
                      child: Text(
                        secretText!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white30,
                        ),
                      ),
                    ),
                  ],
                  Center(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 48,
                        color: Colors.white54,
                      ),
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
