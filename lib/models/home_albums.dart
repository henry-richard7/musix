class HomeAlbums {
  String? query;
  String? text;
  String? year;
  String? image;
  String? albumid;
  String? title;
  Artist? artist;
  int? weight;
  String? language;

  HomeAlbums(
      {this.query,
      this.text,
      this.year,
      this.image,
      this.albumid,
      this.title,
      this.artist,
      this.weight,
      this.language});

  HomeAlbums.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    text = json['text'];
    year = json['year'];
    image = json['image'];
    albumid = json['albumid'];
    title = json['title'];
    artist = json['Artist'] != null ? Artist.fromJson(json['Artist']) : null;
    weight = json['weight'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['query'] = query;
    data['text'] = text;
    data['year'] = year;
    data['image'] = image;
    data['albumid'] = albumid;
    data['title'] = title;
    if (artist != null) {
      data['Artist'] = artist!.toJson();
    }
    data['weight'] = weight;
    data['language'] = language;
    return data;
  }
}

class Artist {
  List<Music>? music;

  Artist({this.music});

  Artist.fromJson(Map<String, dynamic> json) {
    if (json['music'] != null) {
      music = <Music>[];
      json['music'].forEach((v) {
        music!.add(Music.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (music != null) {
      data['music'] = music!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Music {
  String? id;
  String? name;

  Music({this.id, this.name});

  Music.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
