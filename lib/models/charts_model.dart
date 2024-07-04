class Charts {
  String? listid;
  String? listname;
  String? image;
  int? weight;
  List<Songs>? songs;
  String? permaUrl;

  Charts(
      {this.listid,
      this.listname,
      this.image,
      this.weight,
      this.songs,
      this.permaUrl});

  Charts.fromJson(Map<String, dynamic> json) {
    listid = json['listid'];
    listname = json['listname'];
    image = json['image'];
    weight = json['weight'];
    if (json['songs'] != null) {
      songs = <Songs>[];
      json['songs'].forEach((v) {
        songs!.add(Songs.fromJson(v));
      });
    }
    permaUrl = json['perma_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['listid'] = listid;
    data['listname'] = listname;
    data['image'] = image;
    data['weight'] = weight;
    if (songs != null) {
      data['songs'] = songs!.map((v) => v.toJson()).toList();
    }
    data['perma_url'] = permaUrl;
    return data;
  }
}

class Songs {
  String? name;
  String? image;

  Songs({this.name, this.image});

  Songs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
