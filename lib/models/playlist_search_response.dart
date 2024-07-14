class PlaylistSearchResponse {
  String? id;
  String? title;
  String? image;
  String? extra;
  String? url;
  String? language;
  String? type;
  String? description;
  int? position;
  Null moreInfo;

  PlaylistSearchResponse(
      {this.id,
      this.title,
      this.image,
      this.extra,
      this.url,
      this.language,
      this.type,
      this.description,
      this.position,
      this.moreInfo});

  PlaylistSearchResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    extra = json['extra'];
    url = json['url'];
    language = json['language'];
    type = json['type'];
    description = json['description'];
    position = json['position'];
    moreInfo = json['more_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['extra'] = extra;
    data['url'] = url;
    data['language'] = language;
    data['type'] = type;
    data['description'] = description;
    data['position'] = position;
    data['more_info'] = moreInfo;
    return data;
  }
}
