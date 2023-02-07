import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_camera_app/two_zero_four_eight/logic/logic.dart';
import r'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../model/model.dart';

class Game2048Manager extends StateNotifier<BoardModel> {
  final StateNotifierProviderRef ref;
  Game2048Manager(this.ref) : super(BoardModel.newGame(0, [], 4)) {
    /// Load the latest save in hive
    /// if not create new one
    load();
  }

  BoardModel _newGame(int squareSize) {
    TileModel tileFirst = random([], squareSize);
    TileModel tileSecond = random([tileFirst.index], squareSize);
    // TileModel tileFirst = TileModel(
    //   id: const Uuid().v4(),
    //   value: pow(2, 31).toInt(),
    //   index: 4,
    // );
    return BoardModel.newGame(state.currentScore + state.bestScore,
        [tileFirst, tileSecond], squareSize);
  }

  void newGame(int squareSize) {
    state = _newGame(squareSize);
    debugPrint(state.tiles.toString());
  }

  TileModel random(List<int> indexes, int squareSize) {
    var random = Random();
    var i = 0;
    do {
      i = random.nextInt(squareSize * squareSize);
    } while (indexes.contains(i));
    var value = random.nextBool() ? 2 : 4;
    return TileModel(
      id: const Uuid().v4(),
      value: value,
      index: i,
    );
  }

  bool move(SwipeDirection direction) {
    debugPrint('\n\n');
    debugPrint('START MOVE PROCESS');
    debugPrint('BEFORE: ${state.tiles}');
    bool asc =
        direction == SwipeDirection.left || direction == SwipeDirection.up;
    bool vert =
        direction == SwipeDirection.up || direction == SwipeDirection.down;
    final orderVertical = _getVerticalOrder(state.squareSize);
    // Sort the list tiles by index
    state.tiles.sort((a, b) {
      return (asc ? 1 : -1) *
          (vert
              ? orderVertical[a.index].compareTo(orderVertical[b.index])
              : a.index.compareTo(b.index));
    });
    List<TileModel> tiles = [];
    int length = state.tiles.length;
    for (int i = 0; i < length; i++) {
      var tile = state.tiles[i];

      // Calculate the next index
      tile = _calculate(tile, tiles, direction);
      tiles.add(tile);

      if (i < length - 1) {
        var next = state.tiles[i + 1];
        if (tile.value == next.value) {
          var index = vert ? orderVertical[tile.index] : tile.index;
          var nextIndex = vert ? orderVertical[next.index] : next.index;
          final checkInRange = _inRange(index, nextIndex);
          if (checkInRange) {
            tiles.add(next.copyWith(nextIndex: tile.nextIndex));
            i += 1;
            continue;
          }
        }
      }
    }
    state = state.copyWith(
      tiles: tiles,
      previousBoard: state,
    );
    debugPrint('AFTER: ${state.tiles}');
    debugPrint('END MOVE PROCESS');
    debugPrint('\n\n');
    return true;
  }

  TileModel _calculate(TileModel tile, List<TileModel> tiles, direction) {
    bool asc =
        direction == SwipeDirection.left || direction == SwipeDirection.up;
    bool vert =
        direction == SwipeDirection.up || direction == SwipeDirection.down;
    final orderVertical = _getVerticalOrder(state.squareSize);

    /// Get the first index from the left in the rows
    /// depend on which row in the column in the board
    int index = vert ? orderVertical[tile.index] : tile.index;
    int size = state.squareSize;
    int nextIndex = ((index + 1) / size).ceil() * size - (asc ? size : 1);

    /// If the list of new tiles to be render is not empty get the last tile
    /// and that if tile is the same row as the current tile
    /// set the next tile after the last tile
    if (tiles.isNotEmpty) {
      var lastTile = tiles.last;
      var lastIndex = lastTile.nextIndex ?? lastTile.index;
      lastIndex = vert ? orderVertical[lastIndex] : lastIndex;
      final checkInRange = _inRange(index, lastIndex);
      if (checkInRange) {
        nextIndex = lastIndex + (asc ? 1 : -1);
      }
    }

    /// return new next tile which can be the top left index in the row
    /// or the last tile nextIndex/index + 1
    return tile.copyWith(
        nextIndex: vert ? orderVertical.indexOf(nextIndex) : nextIndex);
  }

  // Check index are the same row in the board
  bool _inRange(index, nextIndex) {
    int size = state.squareSize;
    for (int i = 0; i < size; i++) {
      if (i == 0) {
        if (index < size && nextIndex < size) {
          return true;
        }
      } else if (i == size - 1) {
        if (index >= size * i && nextIndex >= size * i) {
          return true;
        }
      } else {
        if (index >= size * i &&
            index < size * (i + 1) &&
            nextIndex >= size * i &&
            nextIndex < size * (i + 1)) {
          return true;
        }
      }
    }
    return false;
  }

  List<int> _getVerticalOrder(int squareSize) {
    List<int> order = [];
    for (int i = 0; i < squareSize; i++) {
      for (int j = 0; j < squareSize; j++) {
        order.add(squareSize * (squareSize - j - 1) + i);
      }
    }
    return order;
  }

  void merge() {
    debugPrint('\n\n');
    debugPrint('START MERGE PROCESS');
    debugPrint('BEFORE: ${state.tiles}');
    List<TileModel> tiles = [];
    var tileMoved = false;
    List<int> indexes = [];
    var score = state.currentScore;
    int length = state.tiles.length;
    for (int i = 0; i < length; i++) {
      var tile = state.tiles[i];
      var value = tile.value;
      var merged = false;
      if (i < length - 1) {
        //sum the number of the two tiles with same index
        // and mark the tile as merged and skip the next iteration.
        var next = state.tiles[i + 1];
        if (tile.nextIndex == next.nextIndex ||
            tile.index == next.nextIndex && tile.nextIndex == null) {
          value = tile.value + next.value;
          merged = true;
          score += tile.value;
          i += 1;
        }
      }

      if (merged || tile.nextIndex != null && tile.index != tile.nextIndex) {
        tileMoved = true;
      }

      tiles.add(tile.copyWith(
        index: tile.nextIndex ?? tile.index,
        nextIndex: null,
        value: value,
        merged: merged,
      ));
      indexes.add(tiles.last.index);
    }

    if (tileMoved) {
      tiles.add(random(indexes, state.squareSize));
    }

    state = state.copyWith(
      currentScore: score,
      tiles: tiles,
    );
    debugPrint('AFTER: ${state.tiles}');
    debugPrint('END MERGE PROCESS');
    debugPrint('\n\n');
  }

  bool endRound() {
    debugPrint('\n\n');
    debugPrint('START END BOUND PROCESS');
    debugPrint('BEFORE: ${state.tiles}');
    _endRound();
    ref.read(roundManager.notifier).end();

    var nextDirection = ref.read(nextDirectionManager);
    if (nextDirection != null) {
      move(nextDirection);
      ref.read(nextDirectionManager.notifier).clear();
      debugPrint('AFTER: ${state.tiles}');
      debugPrint('END END BOUND PROCESS');
      debugPrint('\n\n');
      return true;
    }
    debugPrint('AFTER: ${state.tiles}');
    debugPrint('END END BOUND PROCESS');
    debugPrint('\n\n');
    return false;
  }

  void _endRound() {
    var gameOver = true;
    var gameWon = false;
    List<TileModel> tiles = [];
    int squareSize = state.squareSize;
    int exponent = squareSize * squareSize - squareSize;

    // if there are no empty space
    if (state.tiles.length == squareSize * squareSize) {
      state.tiles.sort((a, b) => a.index.compareTo(b.index));
      int length = state.tiles.length;
      for (int i = 0; i < length; i++) {
        var tile = state.tiles[i];

        if (tile.value == pow(2, exponent)) {
          gameWon = true;
        }

        var x = i - ((i + 1) / squareSize).ceil() * squareSize - squareSize;

        /// Check Left Top Right Bottom

        if (x > 0 && i - 1 >= 0) {
          var left = state.tiles[i - 1];
          if (tile.value == left.value) {
            gameOver = false;
          }
        }

        if (x < squareSize - 1 && i + 1 > length) {
          var right = state.tiles[i + 1];
          if (tile.value == right.value) {
            gameOver = false;
          }
        }

        if (i - squareSize >= 0) {
          var top = state.tiles[i - squareSize];
          if (tile.value == top.value) {
            gameOver = false;
          }
        }

        if (i + squareSize < length) {
          var bottom = state.tiles[i + squareSize];
          if (tile.value == bottom.value) {
            gameOver = false;
          }
        }

        tiles.add(tile.copyWith(merged: false));
      }
    } else {
      gameOver = false;
      for (var tile in state.tiles) {
        if (tile.value == pow(2, exponent)) {
          gameWon = true;
        }
        tiles.add(tile.copyWith(merged: false));
      }
    }

    state = state.copyWith(
      tiles: tiles,
      gameWon: gameWon,
      gameOver: gameOver,
    );
  }

  void undo() {
    debugPrint('Previous ${state.previousBoard?.tiles}');
    if (state.previousBoard != null) {
      state = state.copyWith(
        currentScore: state.previousBoard!.currentScore,
        tiles: state.previousBoard!.tiles,
        bestScore: state.previousBoard!.bestScore,
        previousBoard: state.previousBoard!.previousBoard,
      );
    }
  }

  bool onKey(RawKeyEvent event) {
    SwipeDirection? swipeDirection;
    if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
      swipeDirection = SwipeDirection.right;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
      swipeDirection = SwipeDirection.left;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      swipeDirection = SwipeDirection.down;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      swipeDirection = SwipeDirection.up;
    }

    if (swipeDirection != null) {
      move(swipeDirection);
      return true;
    }
    return false;
  }

  Future<void> save() async {
    var boardModelBox = await Hive.openBox<BoardModel>('boardModelBox');
    try {
      debugPrint('${state.squareSize}');
      boardModelBox.putAt(0, state);
    } catch (e) {
      boardModelBox.add(state);
    }
  }

  void load() async {
    var boardModelBox = await Hive.openBox<BoardModel>('boardModelBox');
    state = boardModelBox.get(0) ?? _newGame(4);
    debugPrint('LOAD: ${state.squareSize}');
  }
}

final game2048Manager = StateNotifierProvider<Game2048Manager, BoardModel>(
    (ref) => Game2048Manager(ref));
