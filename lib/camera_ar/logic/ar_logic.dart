import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/model/ar_filter_model.dart';

class DeepArLogic extends ChangeNotifier {
  ArModel? filter;
  ArModel? effect;
  ArModel? masked;

  DeepArLogic({
    this.effect,
    this.masked,
    this.filter,
  });

  void chooseArFilter(ArModel filter) {
    this.filter = filter;
    notifyListeners();
  }

  void removeArFilter() {
    filter = null;
    notifyListeners();
  }

  void chooseArEffect(ArModel effect) {
    this.effect = effect;
    notifyListeners();
  }

  void removeArEffect() {
    effect = null;
    notifyListeners();
  }

  void chooseArMasked(ArModel masked) {
    this.masked = masked;
    notifyListeners();
  }

  void removeArMasked() {
    masked = null;
    notifyListeners();
  }
}
