import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class GameData extends ChangeNotifier with HiveObjectMixin {
  @HiveField(0)
  int highScore = 0;

  @HiveField(1)
  int currentScore = 0;
}
