class FeaturedPlaylists {
  String? listid;
  String? secondarySubtitle;
  String? firstname;
  String? listname;
  String? dataType;
  int? count;
  String? image;
  bool? sponsored;
  String? permaUrl;
  String? followerCount;
  String? uid;
  int? lastUpdated;

  FeaturedPlaylists(
      {this.listid,
      this.secondarySubtitle,
      this.firstname,
      this.listname,
      this.dataType,
      this.count,
      this.image,
      this.sponsored,
      this.permaUrl,
      this.followerCount,
      this.uid,
      this.lastUpdated});

  FeaturedPlaylists.fromJson(Map<String, dynamic> json) {
    listid = json['listid'];
    secondarySubtitle = json['secondary_subtitle'];
    firstname = json['firstname'];
    listname = json['listname'];
    dataType = json['data_type'];
    count = json['count'];
    image = json['image'];
    sponsored = json['sponsored'];
    permaUrl = json['perma_url'];
    followerCount = json['follower_count'];
    uid = json['uid'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['listid'] = listid;
    data['secondary_subtitle'] = secondarySubtitle;
    data['firstname'] = firstname;
    data['listname'] = listname;
    data['data_type'] = dataType;
    data['count'] = count;
    data['image'] = image;
    data['sponsored'] = sponsored;
    data['perma_url'] = permaUrl;
    data['follower_count'] = followerCount;
    data['uid'] = uid;
    data['last_updated'] = lastUpdated;
    return data;
  }
}
