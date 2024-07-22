import 'package:flutter/material.dart';
import 'package:musix/models/specific_song_result_model.dart';
import 'package:musix/pages/music_player_page.dart';

class SpecificSongComponent {
  InkWell albumCard(
      SpecificSongResultModel specificSongResult, BuildContext context) {
    return InkWell(
      child: Container(
        width: 250,
        decoration: boxDecoration(specificSongResult),
        child: childElements(specificSongResult),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicPlayerPage(
              songId: specificSongResult.songId.toString(),
            ),
          ),
        );
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
              artistText(specificSongResult),
              releaseYear(specificSongResult)
            ],
          ),
        ),
      ],
    );
  }

  Text releaseYear(SpecificSongResultModel specificSongResult) {
    return Text(
      specificSongResult.year.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
    );
  }

  Text artistText(SpecificSongResultModel specificSongResult) {
    return Text(
      specificSongResult.artist.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
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
          specificSongResult.art.replaceAll("150x150", "500x500"),
        ),
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
