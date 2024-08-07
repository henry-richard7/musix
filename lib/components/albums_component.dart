import 'package:flutter/material.dart';
import 'package:musix/models/home_albums.dart';
import 'package:musix/pages/album_details_page.dart';

class AlbumsComponent {
  InkWell albumCard(HomeAlbums homeAlbum, BuildContext context) {
    return InkWell(
      child: Container(
        width: 250,
        decoration: boxDecoration(homeAlbum),
        child: childElements(homeAlbum),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumDetailsPage(
              albumId: homeAlbum.albumid.toString(),
            ),
          ),
        );
      },
    );
  }

  Stack childElements(HomeAlbums homeAlbum) {
    return Stack(
      children: [
        blackHover(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              titleText(homeAlbum),
              artistText(homeAlbum),
              releaseYear(homeAlbum)
            ],
          ),
        ),
      ],
    );
  }

  Text releaseYear(HomeAlbums homeAlbum) {
    return Text(
      homeAlbum.year.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
    );
  }

  Text artistText(HomeAlbums homeAlbum) {
    return Text(
      homeAlbum.artist!.music![0].name.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  Text titleText(HomeAlbums homeAlbum) {
    return Text(
      homeAlbum.title.toString(),
      textAlign: TextAlign.start,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Container blackHover() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  BoxDecoration boxDecoration(HomeAlbums homeAlbum) {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          homeAlbum.image!.replaceAll("150x150", "500x500"),
        ),
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
