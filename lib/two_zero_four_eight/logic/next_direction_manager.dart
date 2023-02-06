import r'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

class NextDirectionManager extends StateNotifier<SwipeDirection?> {
  final StateNotifierProviderRef ref;
  NextDirectionManager(this.ref) : super(null);

  void queue(direction) {
    state = direction;
  }

  void clear() {
    state = null;
  }
}

final nextDirectionManager =
    StateNotifierProvider<NextDirectionManager, SwipeDirection?>(
        (ref) => NextDirectionManager(ref));
