// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteAdapter extends TypeAdapter<FavoriteItem> {
  @override
  final int typeId = 1;

  @override
  FavoriteItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteItem(
      songId: fields[0] as String,
      songName: fields[1] as String,
      albumName: fields[2] as String,
      art: fields[3] as String,
      primaryArtists: fields[4] as String,
      streamLink: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.songId)
      ..writeByte(1)
      ..write(obj.songName)
      ..writeByte(2)
      ..write(obj.albumName)
      ..writeByte(3)
      ..write(obj.art)
      ..writeByte(4)
      ..write(obj.primaryArtists)
      ..writeByte(5)
      ..write(obj.streamLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
