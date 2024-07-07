import 'package:flutter/material.dart';
import 'package:musix/models/featured_playlist.dart';

class PlaylistComponent {
  InkWell playlistComponent(
      FeaturedPlaylists featuredPlaylists, BuildContext context) {
    return InkWell(
      child: Container(
        width: 250,
        decoration: boxDecoration(featuredPlaylists),
      ),
      onTap: () {
        print(featuredPlaylists.listid);
      },
    );
  }

  BoxDecoration boxDecoration(FeaturedPlaylists featuredPlaylists) {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          featuredPlaylists.image.toString(),
        ),
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
    );
  }
}
