class ArtistSearchResponse {
  String? id;
  String? title;
  String? image;
  String? extra;
  String? url;
  String? type;
  String? description;
  int? ctr;
  int? entity;
  int? position;

  ArtistSearchResponse(
      {this.id,
      this.title,
      this.image,
      this.extra,
      this.url,
      this.type,
      this.description,
      this.ctr,
      this.entity,
      this.position});

  ArtistSearchResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    extra = json['extra'];
    url = json['url'];
    type = json['type'];
    description = json['description'];
    ctr = json['ctr'];
    entity = json['entity'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['extra'] = extra;
    data['url'] = url;
    data['type'] = type;
    data['description'] = description;
    data['ctr'] = ctr;
    data['entity'] = entity;
    data['position'] = position;
    return data;
  }
}
