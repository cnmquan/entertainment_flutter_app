// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret_controller.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SecretControllerAdapter extends TypeAdapter<SecretController> {
  @override
  final int typeId = 6;

  @override
  SecretController read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SecretController().._isAnswer = fields[0] as bool;
  }

  @override
  void write(BinaryWriter writer, SecretController obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._isAnswer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SecretControllerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
