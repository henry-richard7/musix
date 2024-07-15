import 'package:flutter/material.dart';
import 'package:musix/pages/album_details_page.dart';
import 'package:musix/pages/music_player_page.dart';

class TopSongsComponent {
  InkWell topSongCard(
    String songId,
    String title,
    String image,
    String year,
    String album,
    String type,
    BuildContext context,
  ) {
    return InkWell(
      child: Container(
        width: 250,
        decoration: boxDecoration(image),
        child: childElements(
          title,
          year,
          album,
        ),
      ),
      onTap: () {
        {
          if (type == 'song') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MusicPlayerPage(
                  songId: songId,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlbumDetailsPage(
                  albumId: songId,
                ),
              ),
            );
          }
        }
      },
    );
  }

  Stack childElements(String title, String year, String album) {
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
              titleText(title),
              albumText(album),
              releaseYear(year),
            ],
          ),
        ),
      ],
    );
  }

  Text releaseYear(String year) {
    return Text(
      year,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
    );
  }

  Text albumText(String album) {
    return Text(
      album,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  Text titleText(String title) {
    return Text(
      title.toString(),
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

  BoxDecoration boxDecoration(
    String image,
  ) {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          image.replaceAll("150x150", "500x500"),
        ),
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
