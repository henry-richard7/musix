class SongSearchResponse {
  String? id;
  String? title;
  String? image;
  String? album;
  String? url;
  String? type;
  String? description;
  int? ctr;
  int? position;
  MoreInfo? moreInfo;

  SongSearchResponse(
      {this.id,
      this.title,
      this.image,
      this.album,
      this.url,
      this.type,
      this.description,
      this.ctr,
      this.position,
      this.moreInfo});

  SongSearchResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    album = json['album'];
    url = json['url'];
    type = json['type'];
    description = json['description'];
    ctr = json['ctr'];
    position = json['position'];
    moreInfo =
        json['more_info'] != null ? MoreInfo.fromJson(json['more_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['album'] = album;
    data['url'] = url;
    data['type'] = type;
    data['description'] = description;
    data['ctr'] = ctr;
    data['position'] = position;
    if (moreInfo != null) {
      data['more_info'] = moreInfo!.toJson();
    }
    return data;
  }
}

class MoreInfo {
  String? primaryArtists;
  String? singers;
  Null videoAvailable;
  bool? trillerAvailable;
  String? language;

  MoreInfo(
      {this.primaryArtists,
      this.singers,
      this.videoAvailable,
      this.trillerAvailable,
      this.language});

  MoreInfo.fromJson(Map<String, dynamic> json) {
    primaryArtists = json['primary_artists'];
    singers = json['singers'];
    videoAvailable = json['video_available'];
    trillerAvailable = json['triller_available'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['primary_artists'] = primaryArtists;
    data['singers'] = singers;
    data['video_available'] = videoAvailable;
    data['triller_available'] = trillerAvailable;
    data['language'] = language;
    return data;
  }
}
