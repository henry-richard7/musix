import 'package:hive/hive.dart';

part 'favorite.g.dart';

@HiveType(typeId: 1, adapterName: "FavoriteAdapter")
class FavoriteItem {
  @HiveField(0)
  String songName;

  @HiveField(1)
  String albumName;

  @HiveField(2)
  String art;

  @HiveField(3)
  String primaryArtists;

  @HiveField(4)
  String streamLink;

  FavoriteItem(
      {required this.songName,
      required this.albumName,
      required this.art,
      required this.primaryArtists,
      required this.streamLink});
}
