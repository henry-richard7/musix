import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 1, adapterName: "FavoriteAdapter")
class FavoriteItem {
  @HiveField(0)
  String songId;

  @HiveField(1)
  String songName;

  @HiveField(2)
  String albumName;

  @HiveField(3)
  String art;

  @HiveField(4)
  String primaryArtists;

  @HiveField(5)
  String streamLink;

  FavoriteItem({
    required this.songId,
    required this.songName,
    required this.albumName,
    required this.art,
    required this.primaryArtists,
    required this.streamLink,
  });
}
