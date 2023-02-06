// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardModel _$BoardModelFromJson(Map json) => BoardModel(
      currentScore: json['currentScore'] as int,
      bestScore: json['bestScore'] as int,
      tiles: (json['tiles'] as List<dynamic>)
          .map((e) => TileModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      gameOver: json['gameOver'] as bool? ?? false,
      gameWon: json['gameWon'] as bool? ?? false,
      squareSize: json['squareSize'] as int? ?? 4,
      previousBoard: json['previousBoard'] == null
          ? null
          : BoardModel.fromJson(
              Map<String, dynamic>.from(json['previousBoard'] as Map)),
    );

Map<String, dynamic> _$BoardModelToJson(BoardModel instance) =>
    <String, dynamic>{
      'currentScore': instance.currentScore,
      'bestScore': instance.bestScore,
      'tiles': instance.tiles.map((e) => e.toJson()).toList(),
      'gameOver': instance.gameOver,
      'gameWon': instance.gameWon,
      'squareSize': instance.squareSize,
      'previousBoard': instance.previousBoard?.toJson(),
    };
