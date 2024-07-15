import 'package:flutter/material.dart';
import 'package:musix/models/playlist_search_response.dart';
import 'package:musix/pages/playlist_details_page.dart';

class PlaylistsSearchComponent {
  InkWell albumCard(
      PlaylistSearchResponse playlistSearchResponse, BuildContext context) {
    return InkWell(
      child: Container(
        width: 250,
        decoration: boxDecoration(playlistSearchResponse),
        child: childElements(playlistSearchResponse),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistDetailsPage(
              playlistId: playlistSearchResponse.id.toString(),
            ),
          ),
        );
      },
    );
  }

  Stack childElements(PlaylistSearchResponse playlistSearchResponse) {
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
              titleText(playlistSearchResponse),
            ],
          ),
        ),
      ],
    );
  }

  Text titleText(PlaylistSearchResponse playlistSearchResponse) {
    return Text(
      playlistSearchResponse.title.toString(),
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

  BoxDecoration boxDecoration(PlaylistSearchResponse playlistSearchResponse) {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          playlistSearchResponse.image!.replaceAll("50x50", "500x500"),
        ),
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
