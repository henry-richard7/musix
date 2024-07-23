import 'package:flutter/material.dart';
import 'package:musix/models/specific_song_result_model.dart';
import 'package:musix/pages/artist_details_page.dart';
import 'package:musix/pages/playlist_details_page.dart';

class SpecificArstPlaylstComponent {
  InkWell albumCard(
      SpecificSongResultModel specificSongResult, BuildContext context) {
    return InkWell(
      child: Container(
        width: 250,
        decoration: boxDecoration(specificSongResult),
        child: childElements(specificSongResult),
      ),
      onTap: () {
        if (specificSongResult.type == "artist") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArtistDetailsPage(
                artistId: specificSongResult.songId.toString(),
              ),
            ),
          );
        } else if (specificSongResult.type == "playlist") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaylistDetailsPage(
                playlistId: specificSongResult.songId.toString(),
              ),
            ),
          );
        }
      },
    );
  }

  Stack childElements(SpecificSongResultModel specificSongResult) {
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
              titleText(specificSongResult),
            ],
          ),
        ),
      ],
    );
  }

  Text titleText(SpecificSongResultModel specificSongResult) {
    return Text(
      specificSongResult.songName.toString(),
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

  BoxDecoration boxDecoration(SpecificSongResultModel specificSongResult) {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          specificSongResult.art
              .replaceAll("50x50", "500x500")
              .replaceAll("150x150", "500x500"),
        ),
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
