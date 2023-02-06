import 'package:flutter/material.dart';
import 'package:flutter_camera_app/two_zero_four_eight/logic/game_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widget.dart';

class ScoreBoardWidget extends ConsumerWidget {
  const ScoreBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentScore = ref
        .watch(game2048Manager.select((boardModel) => boardModel.currentScore));
    final bestScore =
        ref.watch(game2048Manager.select((boardModel) => boardModel.bestScore));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScorePointWidget(
          label: 'Score',
          score: '$currentScore',
        ),
        const SizedBox(
          width: 8.0,
        ),
        ScorePointWidget(
          label: 'Best',
          score: '$bestScore',
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ],
    );
  }
}
