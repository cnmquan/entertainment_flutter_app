import r'package:flutter_riverpod/flutter_riverpod.dart';

class RoundManager extends StateNotifier<bool> {
  final StateNotifierProviderRef ref;
  RoundManager(this.ref) : super(true);

  void end() {
    state = true;
  }

  void start() {
    state = false;
  }
}

final roundManager =
    StateNotifierProvider<RoundManager, bool>((ref) => RoundManager(ref));
