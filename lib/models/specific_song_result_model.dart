class SpecificSongResultModel {
  final String songId;
  final String songName;
  final String albumName;
  final String art;
  final String artist;
  final String year;
  final String type;

  SpecificSongResultModel(
      {required this.songId,
      required this.songName,
      required this.albumName,
      required this.art,
      required this.artist,
      required this.year,
      required this.type});
}
