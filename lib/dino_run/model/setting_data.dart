import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'setting_data.g.dart';

@HiveType(typeId: 1)
class SettingData extends ChangeNotifier with HiveObjectMixin {
  SettingData(
      {bool bgm = false, bool sfx = false, int form = 0, int level = 1}) {
    _bgm = bgm;
    _sfx = sfx;
    _form = form;
    _level = level;
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

  @HiveField(2)
  int? _form = 0;

  int? get form => _form;
  set form(int? value) {
    _form = value;
    notifyListeners();
    save();
  }

  @HiveField(3)
  int? _level = 1;

  int? get level => _level;
  set level(int? value) {
    _level = value;
    notifyListeners();
    save();
  }
}
