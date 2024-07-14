import 'package:flutter/material.dart';
import 'package:musix/models/song_search_response.dart';
import 'package:musix/pages/music_player_page.dart';

class SongsSearchComponent {
  InkWell albumCard(
      SongSearchResponse songSearchResponse, BuildContext context) {
    return InkWell(
      child: Container(
        width: 250,
        decoration: boxDecoration(songSearchResponse),
        child: childElements(songSearchResponse),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicPlayerPage(
              songId: songSearchResponse.id.toString(),
            ),
          ),
        );
      },
    );
  }

  Stack childElements(SongSearchResponse songSearchResponse) {
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
              titleText(songSearchResponse),
              artistText(songSearchResponse),
              releaseYear(songSearchResponse)
            ],
          ),
        ),
      ],
    );
  }

  Text releaseYear(SongSearchResponse songSearchResponse) {
    return Text(
      songSearchResponse.album.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
    );
  }

  Text artistText(SongSearchResponse songSearchResponse) {
    return Text(
      songSearchResponse.moreInfo!.primaryArtists.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  Text titleText(SongSearchResponse songSearchResponse) {
    return Text(
      songSearchResponse.title.toString(),
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

  BoxDecoration boxDecoration(SongSearchResponse songSearchResponse) {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          songSearchResponse.image!.replaceAll("50x50", "500x500"),
        ),
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
