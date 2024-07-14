import 'package:flutter/material.dart';
import 'package:musix/models/album_search_model.dart';
import 'package:musix/pages/album_details_page.dart';

class AlbumsSearchComponent {
  InkWell albumCard(
      AlbumSearchResponse albumSearchResponse, BuildContext context) {
    return InkWell(
      child: Container(
        width: 250,
        decoration: boxDecoration(albumSearchResponse),
        child: childElements(albumSearchResponse),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumDetailsPage(
              albumId: albumSearchResponse.id.toString(),
            ),
          ),
        );
      },
    );
  }

  Stack childElements(AlbumSearchResponse albumSearchResponse) {
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
              titleText(albumSearchResponse),
              artistText(albumSearchResponse),
              releaseYear(albumSearchResponse)
            ],
          ),
        ),
      ],
    );
  }

  Text releaseYear(AlbumSearchResponse albumSearchResponse) {
    return Text(
      albumSearchResponse.moreInfo!.year.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
    );
  }

  Text artistText(AlbumSearchResponse albumSearchResponse) {
    return Text(
      albumSearchResponse.music.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
    );
  }

  Text titleText(AlbumSearchResponse albumSearchResponse) {
    return Text(
      albumSearchResponse.title.toString(),
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

  BoxDecoration boxDecoration(AlbumSearchResponse albumSearchResponse) {
    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          albumSearchResponse.image!.replaceAll("50x50", "500x500"),
        ),
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    );
  }
}
