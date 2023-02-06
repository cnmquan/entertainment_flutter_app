// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TileModel _$TileModelFromJson(Map json) => TileModel(
      id: json['id'] as String,
      value: json['value'] as int,
      index: json['index'] as int,
      nextIndex: json['nextIndex'] as int?,
      merged: json['merged'] as bool?,
    );

Map<String, dynamic> _$TileModelToJson(TileModel instance) => <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'index': instance.index,
      'nextIndex': instance.nextIndex,
      'merged': instance.merged,
    };
