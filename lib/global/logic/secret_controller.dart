import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'secret_controller.g.dart';

@HiveType(typeId: 6)
class SecretController extends ChangeNotifier with HiveObjectMixin {
  @HiveField(0)
  bool _isAnswer = false;
  bool get isAnswer => _isAnswer;
  set isAnswer(bool value) {
    _isAnswer = value;
    notifyListeners();
    save();
  }

  bool _isClicked = false;
  bool get isClicked => _isClicked;
  set isClicked(bool value) {
    _isClicked = value;
    notifyListeners();
  }

  SecretController({bool isAnswer = false}) : _isAnswer = isAnswer;
}
