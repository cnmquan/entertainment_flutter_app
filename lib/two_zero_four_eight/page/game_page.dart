import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_camera_app/two_zero_four_eight/logic/logic.dart';
import 'package:flutter_camera_app/two_zero_four_eight/theme/color.dart';
import r'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';

import '../widget/widget.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  int squareSize = 0;
  late final _moveController = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );
  late final _moveAnimation = CurvedAnimation(
    parent: _moveController,
    curve: Curves.easeInOut,
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ref.read(game2048Manager.notifier).merge();
        _scaleController.forward(
          from: 0,
        );
      }
    });
  late final _scaleController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (ref.read(game2048Manager.notifier).endRound()) {
          _moveController.forward(
            from: 0,
          );
        }
      }
    });
  late final _scaleAnimation = CurvedAnimation(
    parent: _scaleController,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _moveAnimation.dispose();
    _scaleAnimation.dispose();
    _moveController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void updateRef() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final boardModel = ref.watch(game2048Manager);
      squareSize = boardModel.squareSize;
      setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        ref.read(game2048Manager.notifier).save();
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    updateRef();
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (ref.read(game2048Manager.notifier).onKey(event)) {
          _moveController.forward(from: 0);
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.backgroundColor,
        appBar: AppBar(
          backgroundColor: ColorManager.backgroundColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
              icon: Icons.arrow_back_ios_new_sharp,
              onPressed: () {
                ref
                    .read(game2048Manager.notifier)
                    .save()
                    .then((value) => Navigator.of(context).maybePop());
              },
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '2048',
                style: TextStyle(
                    color: ColorManager.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 64.0),
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ScoreBoardWidget(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ButtonLevelWidget(
                        level: squareSize - 3,
                        onPress: (value) {
                          if (value != null && value != squareSize - 3) {
                            squareSize = value + 3;
                            ref
                                .read(game2048Manager.notifier)
                                .newGame(squareSize);
                            setState(() {});
                          }
                        },
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      ButtonWidget(
                        icon: Icons.undo,
                        onPressed: () {
                          ref.read(game2048Manager.notifier).undo();
                        },
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      ButtonWidget(
                        icon: Icons.refresh,
                        onPressed: () {
                          ref
                              .read(game2048Manager.notifier)
                              .newGame(squareSize);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
            if (squareSize == 0) ...[
              const Center(
                child: SpinKitPouringHourGlassRefined(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ] else ...[
              SwipeDetector(
                onSwipe: (direction, offset) {
                  debugPrint(direction.name);
                  if (ref.read(game2048Manager.notifier).move(direction)) {
                    _moveController.forward(from: 0);
                  }
                },
                child: Stack(
                  children: [
                    EmptyBoardWidget(
                      squareSize: squareSize,
                    ),
                    TileBoardWidget(
                      moveAnimation: _moveAnimation,
                      scaleAnimation: _scaleAnimation,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
