import 'package:json_annotation/json_annotation.dart';

import 'model.dart';

part 'board_model.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class BoardModel {
  final int currentScore;
  final int bestScore;
  final List<TileModel> tiles;
  final bool gameOver;
  final bool gameWon;
  final int squareSize;
  final BoardModel? previousBoard;

  BoardModel({
    required this.currentScore,
    required this.bestScore,
    required this.tiles,
    this.gameOver = false,
    this.gameWon = false,
    this.squareSize = 4,
    this.previousBoard,
  });

  BoardModel copyWith({
    int? currentScore,
    int? bestScore,
    List<TileModel>? tiles,
    bool? gameOver,
    bool? gameWon,
    int? squareSize,
    BoardModel? previousBoard,
  }) {
    return BoardModel(
      currentScore: currentScore ?? this.currentScore,
      bestScore: bestScore ?? this.bestScore,
      tiles: tiles ?? this.tiles,
      gameOver: gameOver ?? this.gameOver,
      gameWon: gameWon ?? this.gameWon,
      squareSize: squareSize ?? this.squareSize,
      previousBoard: previousBoard ?? this.previousBoard,
    );
  }

  // create new board
  BoardModel.newGame(
    this.bestScore,
    this.tiles,
    this.squareSize,
  )   : currentScore = 0,
        gameWon = false,
        gameOver = false,
        previousBoard = null;

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);

  Map<String, dynamic> toJson() => _$BoardModelToJson(this);
}
