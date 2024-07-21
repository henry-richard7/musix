class FavoriteModel {
  final String songName;
  final String albumName;
  final String art;
  final String primaryArtists;
  final String streamLink;

  const FavoriteModel({
    required this.songName,
    required this.albumName,
    required this.art,
    required this.primaryArtists,
    required this.streamLink,
  });
}
