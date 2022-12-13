// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingDataAdapter extends TypeAdapter<SettingData> {
  @override
  final int typeId = 1;

  @override
  SettingData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingData()
      .._bgm = fields[0] as bool
      .._sfx = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, SettingData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._bgm)
      ..writeByte(1)
      ..write(obj._sfx);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
