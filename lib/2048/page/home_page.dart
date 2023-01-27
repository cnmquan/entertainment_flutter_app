import 'package:flutter/material.dart';
import 'package:flutter_camera_app/2048/theme/color.dart';

import '../model.dart';
import '../widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<int>> grid = [];
  List<List<int>> gridNew = [];
  int highScore = 0;
  int score = 0;
  int squareSize = 4;
  bool isGameOver = false;
  bool isGameWon = false;

  List<Widget> getGrid(double width, double height) {
    List<Widget> grids = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        int num = grid[i][j];
        String number;
        Color color;
        if (num == 0) {
          color = ColorTheme.emptyGridBackground;
          number = "";
        } else if (num == 2 || num == 4) {
          color = ColorTheme.gridColorTwoFour;
          number = "$num";
        } else if (num == 8 || num == 64 || num == 256) {
          color = ColorTheme.gridColorEightSixtyFourTwoFiftySix;
          number = "$num";
        } else if (num == 16 || num == 32 || num == 1024) {
          color = ColorTheme.gridColorSixteenThirtyTwoOneZeroTwoFour;
          number = "$num";
        } else if (num == 128 || num == 512) {
          color = ColorTheme.gridColorOneTwentyEightFiveOneTwo;
          number = "$num";
        } else {
          color = ColorTheme.gridColorWin;
          number = "$num";
        }
        double size = 0;
        String n = number;
        switch (n.length) {
          case 1:
          case 2:
            size = 40.0;
            break;
          case 3:
            size = 30.0;
            break;
          case 4:
            size = 20.0;
            break;
        }
        grids.add(TileWidget(
          number: number,
          width: width,
          height: height,
          size: size,
          color: color,
        ));
      }
    }
    return grids;
  }

  void handleGesture(int direction) {
    /*

      0 = up
      1 = down
      2 = left
      3 = right
    */
    bool flipped = false;
    bool played = true;
    bool rotated = false;
    if (direction == 0) {
      setState(() {
        grid = GridModel.transposeGrid(grid, squareSize);
        grid = GridModel.flipGrid(grid, squareSize);
        rotated = true;
        flipped = true;
      });
    } else if (direction == 1) {
      setState(() {
        grid = GridModel.transposeGrid(grid, squareSize);
        rotated = true;
      });
    } else if (direction == 2) {
    } else if (direction == 3) {
      setState(() {
        grid = GridModel.flipGrid(grid, squareSize);
        flipped = true;
      });
    } else {
      played = false;
    }

    if (played) {
      debugPrint('playing');
      List<List<int>> past = GridModel.copyGrid(grid, squareSize);
      debugPrint('past $past');
      for (int i = 0; i < squareSize; i++) {
        setState(() {
          List result = GameModel.operate(grid[i], score, highScore);
          score = result[0];
          debugPrint('score in set state $score');
          grid[i] = result[1];
        });
      }
      setState(() {
        grid = GridModel.addNumber(grid, gridNew, squareSize);
      });
      bool changed = GridModel.compare(past, grid, squareSize);
      debugPrint('changed $changed');
      if (flipped) {
        setState(() {
          grid = GridModel.flipGrid(grid, squareSize);
        });
      }

      if (rotated) {
        setState(() {
          grid = GridModel.transposeGrid(grid, squareSize);
        });
      }

      if (changed) {
        setState(() {
          grid = GridModel.addNumber(grid, gridNew, squareSize);
          debugPrint('is changed');
        });
      } else {
        debugPrint('not changed');
      }

      bool gameOver = GameModel.isGameOver(grid, squareSize);
      if (gameOver) {
        debugPrint('game over');
        setState(() {
          isGameOver = true;
        });
      }

      bool gameWon = GameModel.isGameWon(grid, squareSize);
      if (gameWon) {
        debugPrint("GAME WON");
        setState(() {
          isGameWon = true;
        });
      }
      debugPrint('$grid');
      debugPrint('$score');
    }
  }

  @override
  void initState() {
    initialGame();
    super.initState();
  }

  void initialGame({bool restart = false}) {
    grid = GridModel.createBlankGrid(squareSize);
    gridNew = GridModel.createBlankGrid(squareSize);
    GridModel.addNumber(grid, gridNew, squareSize);
    GridModel.addNumber(grid, gridNew, squareSize);

    if (restart) {
      score = 0;
      isGameOver = false;
      isGameWon = false;
    }
  }

  Future<String> getHighScore() async {
    int score = highScore;
    return score.toString();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double gridWidth = (width - 80) / 4;
    double gridHeight = gridWidth;
    double height = 30 + (gridHeight * 4) + 10;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '2048',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorTheme.gridBackground,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: ColorTheme.gridBackground,
                  ),
                  height: 82.0,
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 2.0),
                        child: Text(
                          'Score',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          '$score',
                          style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: height,
                color: ColorTheme.gridBackground,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        child: GridView.count(
                          primary: false,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          crossAxisCount: 4,
                          children: getGrid(gridWidth, gridHeight),
                        ),
                        onVerticalDragEnd: (DragEndDetails details) {
                          //primaryVelocity -ve up +ve down
                          if (details.primaryVelocity == null) {
                            return;
                          }
                          if (details.primaryVelocity! < 0) {
                            handleGesture(0);
                          } else if (details.primaryVelocity! > 0) {
                            handleGesture(1);
                          }
                        },
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity == null) {
                            return;
                          }
                          //-ve right, +ve left
                          if (details.primaryVelocity! > 0) {
                            handleGesture(2);
                          } else if (details.primaryVelocity! < 0) {
                            handleGesture(3);
                          }
                        },
                      ),
                    ),
                    isGameOver
                        ? Container(
                            height: height,
                            color: ColorTheme.transparentWhite,
                            child: Center(
                              child: Text(
                                'Game over!',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorTheme.gridBackground,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    isGameWon
                        ? Container(
                            height: height,
                            color: ColorTheme.transparentWhite,
                            child: Center(
                              child: Text(
                                'You Won!',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: ColorTheme.gridBackground,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: ColorTheme.gridBackground,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(
                          iconSize: 35.0,
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              initialGame(restart: true);
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: ColorTheme.gridBackground,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'High Score',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold),
                            ),
                            FutureBuilder<String>(
                              future: getHighScore(),
                              builder: (ctx, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else {
                                  return const Text(
                                    '0',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
