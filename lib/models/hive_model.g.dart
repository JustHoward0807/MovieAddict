// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveModelAdapter extends TypeAdapter<HiveModel> {
  @override
  final int typeId = 0;

  @override
  HiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveModel()
      ..movieId = fields[0] as String
      ..movieCnName = fields[1] as String
      ..movieEnName = fields[2] as String
      ..movieRating = fields[3] as String
      ..movieImdbRating = fields[4] as String
      ..movieDuration = fields[5] as String
      ..movieCategory = (fields[6] as List)?.cast<String>()
      ..releaseMovieTime = fields[7] as String
      ..movieTrailer = fields[8] as String
      ..moviePoster = fields[9] as String
      ..moviePhotos = (fields[10] as List)?.cast<String>()
      ..movieIntroduction = fields[11] as String
      ..actors = (fields[12] as List)?.cast<Actor>();
  }

  @override
  void write(BinaryWriter writer, HiveModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.movieId)
      ..writeByte(1)
      ..write(obj.movieCnName)
      ..writeByte(2)
      ..write(obj.movieEnName)
      ..writeByte(3)
      ..write(obj.movieRating)
      ..writeByte(4)
      ..write(obj.movieImdbRating)
      ..writeByte(5)
      ..write(obj.movieDuration)
      ..writeByte(6)
      ..write(obj.movieCategory)
      ..writeByte(7)
      ..write(obj.releaseMovieTime)
      ..writeByte(8)
      ..write(obj.movieTrailer)
      ..writeByte(9)
      ..write(obj.moviePoster)
      ..writeByte(10)
      ..write(obj.moviePhotos)
      ..writeByte(11)
      ..write(obj.movieIntroduction)
      ..writeByte(12)
      ..write(obj.actors);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
