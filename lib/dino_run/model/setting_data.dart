import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'setting_data.g.dart';

@HiveType(typeId: 1)
class SettingData extends ChangeNotifier with HiveObjectMixin {
  SettingData({bool bgm = false, bool sfx = false}) {
    _bgm = bgm;
    _sfx = sfx;
  }

  @HiveField(0)
  bool _bgm = false;

  bool get bgm => _bgm;
  set bgm(bool value) {
    _bgm = value;
    notifyListeners();
    save();
  }

  @HiveField(1)
  bool _sfx = false;

  bool get sfx => _sfx;
  set sfx(bool value) {
    _sfx = value;
    notifyListeners();
    save();
  }
}
