// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActorAdapter extends TypeAdapter<Actor> {
  @override
  final int typeId = 1;

  @override
  Actor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Actor(
      actorCnName: fields[0] as String,
      actorEnName: fields[1] as String,
      actorPhotos: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Actor obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.actorCnName)
      ..writeByte(1)
      ..write(obj.actorEnName)
      ..writeByte(2)
      ..write(obj.actorPhotos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
