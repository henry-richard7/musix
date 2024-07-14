class AlbumSearchResponse {
  String? id;
  String? title;
  String? image;
  String? music;
  String? url;
  String? type;
  String? description;
  int? ctr;
  int? position;
  MoreInfo? moreInfo;

  AlbumSearchResponse(
      {this.id,
      this.title,
      this.image,
      this.music,
      this.url,
      this.type,
      this.description,
      this.ctr,
      this.position,
      this.moreInfo});

  AlbumSearchResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    music = json['music'];
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
    data['music'] = music;
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
  String? year;
  String? isMovie;
  String? language;
  String? songPids;

  MoreInfo({this.year, this.isMovie, this.language, this.songPids});

  MoreInfo.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    isMovie = json['is_movie'];
    language = json['language'];
    songPids = json['song_pids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['is_movie'] = isMovie;
    data['language'] = language;
    data['song_pids'] = songPids;
    return data;
  }
}
