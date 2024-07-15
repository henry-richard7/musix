import 'package:flutter/material.dart';
import 'package:musix/models/artist_search_response.dart';

class ArtistsSearchComponent {
  InkWell albumCard(
      ArtistSearchResponse artistSearchResponse, BuildContext context) {
    return InkWell(
      child: Container(
        width: 250,
        decoration: boxDecoration(artistSearchResponse),
        child: childElements(artistSearchResponse),
      ),
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => AlbumDetailsPage(
        //       albumId: artistSearchResponse.id.toString(),
        //     ),
        //   ),
        // );
      },
    );
  }

  Stack childElements(ArtistSearchResponse artistSearchResponse) {
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
              titleText(artistSearchResponse),
            ],
          ),
        ),
      ],
    );
  }

  Text titleText(ArtistSearchResponse artistSearchResponse) {
    return Text(
      artistSearchResponse.title.toString(),
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

  BoxDecoration boxDecoration(ArtistSearchResponse artistSearchResponse) {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          artistSearchResponse.image!.replaceAll("50x50", "500x500"),
        ),
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
