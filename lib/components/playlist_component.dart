import 'package:flutter/material.dart';
import 'package:musix/models/featured_playlist.dart';
import 'package:musix/pages/playlist_details_page.dart';

class PlaylistComponent {
  InkWell playlistComponent(
      FeaturedPlaylists featuredPlaylists, BuildContext context) {
    return InkWell(
      child: Container(
        width: 250,
        decoration: boxDecoration(featuredPlaylists),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistDetailsPage(
              playlistId: featuredPlaylists.listid.toString(),
            ),
          ),
        );
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
