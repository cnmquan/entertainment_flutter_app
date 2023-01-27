import 'dart:math';

import 'package:flutter/material.dart';

class GameModel {
  static List operate(List<int> row, int score, int highScore) {
    row = slide(row);
    List result = combine(row, score, highScore);
    int sc = result[0];
    row = result[1];
    row = slide(row);

    debugPrint('from func $sc');
    return [sc, row];
  }

  static List<int> filter(List<int> row) {
    List<int> temp = [];
    for (int i = 0; i < row.length; i++) {
      if (row[i] != 0) {
        temp.add(row[i]);
      }
    }
    return temp;
  }

  static List<int> slide(List<int> row) {
    List<int> arr = filter(row);
    int missing = row.length - arr.length;
    List<int> zeroes = getZeroArray(missing);
    arr = zeroes + arr;
    return arr;
  }

  static List<int> getZeroArray(int length) {
    List<int> zeroes = [];
    for (int i = 0; i < length; i++) {
      zeroes.add(0);
    }
    return zeroes;
  }

  static List combine(List<int> row, int score, int highScore) {
    for (int i = 3; i >= 1; i--) {
      int a = row[i];
      int b = row[i - 1];
      if (a == b) {
        row[i] = a + b;
        score += row[i];
        if (highScore == 0) {
          highScore = score;
        } else {
          if (score > highScore) {
            highScore = score;
          }
        }
        row[i - 1] = 0;
      }
    }
    return [score, row];
  }

  static bool isGameWon(List<List<int>> grid, int squareSize) {
    for (int i = 0; i < squareSize; i++) {
      for (int j = 0; j < squareSize; j++) {
        if (grid[i][j] == pow(2, squareSize - 4)) {
          return true;
        }
      }
    }
    return false;
  }

  static bool isGameOver(List<List<int>> grid, int squareSize) {
    for (int i = 0; i < squareSize; i++) {
      for (int j = 0; j < squareSize; j++) {
        if (grid[i][j] == 0) {
          return false;
        }
        if (i != squareSize - 1 && grid[i][j] == grid[i + 1][j]) {
          return false;
        }
        if (j != squareSize - 1 && grid[i][j] == grid[i][j + 1]) {
          return false;
        }
      }
    }
    return true;
  }
}
