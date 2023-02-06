import 'package:flutter_camera_app/two_zero_four_eight/model/model.dart';
import 'package:hive/hive.dart';

class BoardAdapterModel extends TypeAdapter<BoardModel> {
  @override
  BoardModel read(BinaryReader reader) {
    // Create a board Model from the json when reading stored data
    return BoardModel.fromJson(Map<String, dynamic>.from(reader.read()));
  }

  @override
  int get typeId => 5;

  @override
  void write(BinaryWriter writer, BoardModel obj) {
    // Store Board Model as Json when writing data to database
    writer.write(obj.toJson());
  }
}
