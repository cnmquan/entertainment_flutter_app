import 'point.dart';
import 'dart:math';

class GridModel {
  static List<List<int>> createBlankGrid(int squareSize) {
    List<List<int>> rows = [];

    for (int i = 0; i < squareSize; i++) {
      rows.add(List<int>.generate(squareSize, (index) => 0));
    }

    return rows;
  }

  static compare(List<List<int>> a, List<List<int>> b, int squareSize) {
    for (int i = 0; i < squareSize; i++) {
      for (int j = 0; j < squareSize; j++) {
        if (a[i][j] != b[i][j]) {
          return false;
        }
      }
    }
    return true;
  }

  static List<List<int>> copyGrid(List<List<int>> grid, int squareSize) {
    List<List<int>> extraGrid = createBlankGrid(squareSize);
    for (int i = 0; i < squareSize; i++) {
      for (int j = 0; j < squareSize; j++) {
        extraGrid[i][j] = grid[i][j];
      }
    }
    return extraGrid;
  }

  static List<List<int>> flipGrid(List<List<int>> grid, int squareSize) {
    for (int i = 0; i < squareSize; i++) {
      List<int> row = grid[i];
      grid[i] = row.reversed.toList();
    }
    return grid;
  }

  static List<List<int>> transposeGrid(List<List<int>> grid, int squareSize) {
    List<List<int>> newGrid = createBlankGrid(squareSize);
    for (int i = 0; i < squareSize; i++) {
      for (int j = 0; j < squareSize; j++) {
        newGrid[i][j] = grid[j][i];
      }
    }
    return newGrid;
  }

  static List<List<int>> addNumber(
      List<List<int>> grid, List<List<int>> gridNew, int squareSize) {
    List<Point> options = [];
    for (int i = 0; i < squareSize; i++) {
      for (int j = 0; j < squareSize; j++) {
        if (grid[i][j] == 0) {
          options.add(Point(i, j));
        }
      }
    }
    if (options.isNotEmpty) {
      int spotRandomIndex = Random().nextInt(options.length);
      Point spot = options[spotRandomIndex];
      int r = Random().nextInt(100);
      grid[spot.x][spot.y] = r > 50 ? 4 : 2;
      gridNew[spot.x][spot.y] = 1;
    }

    return grid;
  }
}
