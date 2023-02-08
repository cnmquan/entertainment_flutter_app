import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'barrier.dart';
import 'bird.dart';
import 'flappy_bird_cover_screen.dart';

class FlappyBirdHomePage extends StatefulWidget {
  const FlappyBirdHomePage({super.key});

  @override
  State<FlappyBirdHomePage> createState() => _FlappyBirdHomePageState();
}

class _FlappyBirdHomePageState extends State<FlappyBirdHomePage> {
  //bird variables
  static double birdY = 0;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -4.9; // how strong the gravity is
  double velocity = 2.5; // how strong the jump is
  double birdWidth = 0.1; // out of 2, 2 being the entire width of the screen
  double birdHeight = 0.1; // out of 2, 2 being the entire width of the screen
  bool gameHasStarted = false;
  int score = 0;
  static List<double> barrierX = [2, 2 + 1.5];
  static double barrierWidth = 0.5; //out of 2

  List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];
  void reset() {
    birdY = 0;
    initialPos = birdY;
    height = 0;
    time = 0;
    gravity = -4.9; // how strong the gravity is
    velocity = 3.5; // how strong the jump is
    birdWidth = 0.1; // out of 2, 2 being the entire width of the screen
    birdHeight = 0.1; // out of 2, 2 being the entire width of the screen

    barrierX = [2, 2 + 1.5];
    barrierWidth = 0.5; //out of 2
    barrierHeight = [
      [0.6, 0.4],
      [0.4, 0.6]
    ];
  }

  void startGame() async {
    gameHasStarted = true;
    reset();
    Timer.periodic(const Duration(milliseconds: 10), (timer) async {
      // a real physical jump is the same as an upside down parabola
      // so this is a simple quadratic equation
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });

      if (await shouldIncreaseScore()) {
        setState(() {
          score++;
        });
      }

      if (await birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        // final preferences = await SharedPreferences.getInstance();
        // if (preferences.getInt('bestScore') == null) {
        //   preferences.setInt('bestScore', score);
        // }
        _showDialog(score);
        score = 0;
      }
      moveMap();

      //keep the time going
      time += 0.01;
    });
  }

  Future<bool> shouldIncreaseScore() async {
    if (await birdIsDead()) return false;
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] < 0 &&
          barrierX[i] + barrierWidth > 0 &&
          birdY >= -1 + barrierHeight[i][0] &&
          birdY + birdHeight <= 1 - barrierHeight[i][1]) {
        return true;
      }
    }
    return false;
  }

  Future<bool> birdIsDead() async {
    if (birdY < -1 || birdY > 1) {
      return true;
    }
    //hit barriers
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      "assets/images/flappy_bird/background-night.png",
                    ),
                  ),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      MyBird(
                        birdY: birdY,
                        birdWidth: birdWidth,
                        birdHeight: birdHeight,
                      ),

                      //Top barrier 0
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[0][0],
                        isThisBottomBarBarrier: false,
                      ),
                      MyBarrier(
                        barrierX: barrierX[0],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[0][1],
                        isThisBottomBarBarrier: true,
                      ),
                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[1][0],
                        isThisBottomBarBarrier: false,
                      ),
                      MyBarrier(
                        barrierX: barrierX[1],
                        barrierWidth: barrierWidth,
                        barrierHeight: barrierHeight[1][1],
                        isThisBottomBarBarrier: true,
                      ),
                      FlappyBirdCoverScreen(gameHasStarted: gameHasStarted),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "SCORE",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            fontFamily: r'Audiowide',
                          ),
                        ),
                        Text("${score.toDouble() ~/ 100}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontFamily: r'Audiowide',
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void resetGame() {
    Navigator.pop(context); // dismisses the alert dialog
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      setState(() {
        barrierX[i] -= 0.005;
      });
      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
      }
    }
  }

  Future<int> getBestScore(int currentScore) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int bestScore = pref.getInt('bestScore') ?? 0;
    if (bestScore < currentScore) {
      bestScore = currentScore;
    }
    pref.setInt('bestScore', bestScore);
    debugPrint('best score is ${pref.getInt('bestScore')}');
    return bestScore;
  }

  void _showDialog(int score) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return FutureBuilder<int>(
              future: getBestScore(score),
              builder: (context, snapshot) {
                return AlertDialog(
                  backgroundColor: Colors.brown.shade500,
                  title: Column(
                    children: [
                      const Text(
                        "GAME OVER",
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: r'Audiowide',
                          fontSize: 32,
                          letterSpacing: 3.5,
                          wordSpacing: 4,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'SCORE',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: r'Audiowide',
                                  fontSize: 20,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${score.toDouble() ~/ 100}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: r'Audiowide',
                                  fontSize: 28,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                'BEST',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: r'Audiowide',
                                  fontSize: 24,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${snapshot.data == null ? 0 : snapshot.data!.toDouble() ~/ 100}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: r'Audiowide',
                                  fontSize: 36,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: resetGame,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Material(
                            color: Colors.white.withOpacity(0.84),
                            child: SizedBox(
                              width: 240,
                              height: 60,
                              child: Center(
                                child: Text(
                                  "PLAY AGAIN",
                                  style: TextStyle(
                                    color: Colors.brown.shade500,
                                    fontFamily: r'Audiowide',
                                    fontSize: 24,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  actions: [],
                );
              });
        });
  }
}
