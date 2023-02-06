import 'package:json_annotation/json_annotation.dart';

part 'tile_model.g.dart';

@JsonSerializable(anyMap: true)
class TileModel {
  //Unique id used as ValueKey for the TileWidget
  final String id;

  // The number of tile
  final int value;

  // The index of tile
  final int index;

  final int? nextIndex;
  final bool? merged;

  const TileModel({
    required this.id,
    required this.value,
    required this.index,
    this.nextIndex,
    this.merged,
  });

  TileModel copyWith({
    String? id,
    int? value,
    int? index,
    int? nextIndex,
    bool? merged,
  }) {
    return TileModel(
      id: id ?? this.id,
      value: value ?? this.value,
      index: index ?? this.index,
      nextIndex: nextIndex,
      merged: merged,
    );
  }

  // Calculate the top, left position base on index

  double getTop({
    required double size,
    required int squareSize,
    required double padding,
  }) {
    var rowId = ((index + 1) / squareSize).ceil();
    return (rowId - 1) * size + padding * rowId;
  }

  double getLeft({
    required double size,
    required int squareSize,
    required double padding,
  }) {
    var columnId =
        index - (((index + 1) / squareSize).ceil() * squareSize - squareSize);
    return columnId * size + padding * (columnId + 1);
  }

  double? getNextTop({
    required double size,
    required int squareSize,
    required double padding,
  }) {
    if (nextIndex == null) {
      return null;
    }
    var rowId = ((nextIndex! + 1) / squareSize).ceil();
    return (rowId - 1) * size + padding * rowId;
  }

  double? getNextLeft({
    required double size,
    required int squareSize,
    required double padding,
  }) {
    if (nextIndex == null) {
      return null;
    }
    var columnId = nextIndex! -
        (((nextIndex! + 1) / squareSize).ceil() * squareSize - squareSize);
    return columnId * size + padding * (columnId + 1);
  }

  @override
  String toString() {
    return 'Tile(index:$index, value:$value, nextIndex:$nextIndex, merged:$merged)';
  }

  // Create a tile from Json Data
  factory TileModel.fromJson(Map<String, dynamic> json) =>
      _$TileModelFromJson(json);

  // Generate json data from Tile
  Map<String, dynamic> toJson() => _$TileModelToJson(this);
}
