import 'package:flutter/material.dart';
import 'package:musix/api/jio.dart';
import 'package:musix/components/album_search_component.dart';
import 'package:musix/components/artist_search_component.dart';
import 'package:musix/components/playlist_search_component.dart';
import 'package:musix/components/songs_search_component.dart';
import 'package:musix/models/album_search_model.dart';
import 'package:musix/models/artist_search_response.dart';
import 'package:musix/models/playlist_search_response.dart';
import 'package:musix/models/song_search_response.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchTextFieldController = TextEditingController();

  List<SongSearchResponse> songsResult = [];
  List<AlbumSearchResponse> albumsResult = [];

  List<ArtistSearchResponse> artistsResult = [];
  List<PlaylistSearchResponse> playlistsResult = [];

  void performSearch(String query) {
    JioApi.search(query).then((onValue) {
      setState(() {
        List<dynamic> albumsResult = onValue['albums']['data'];
        List<dynamic> songsResult = onValue['songs']['data'];

        List<dynamic> artistsResult = onValue['artists']['data'];
        List<dynamic> playlistsResult = onValue['playlists']['data'];

        albumsResult =
            albumsResult.map((e) => AlbumSearchResponse.fromJson(e)).toList();

        songsResult =
            songsResult.map((e) => SongSearchResponse.fromJson(e)).toList();

        artistsResult = artistsResult
            .map((e) => ArtistSearchResponse.fromJson(e))
            .toList();

        playlistsResult = playlistsResult
            .map((e) => PlaylistSearchResponse.fromJson(e))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: searchTextFieldController,
                  decoration: const InputDecoration(
                    label: Text("Search"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    if ((searchTextFieldController.text == "") ||
                        (searchTextFieldController.text == " ")) {
                      SnackBar snackBar = SnackBar(
                        content: const Text("Search Cannot Be Empty!"),
                        action: SnackBarAction(
                          label: "Close",
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      performSearch(searchTextFieldController.text);
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
              )
            ],
          ),
        ),
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                if (songsResult.isNotEmpty) songSearchResultsWidgets(),
                if (albumsResult.isNotEmpty) albumSearchResultsWidgets(),
                if (artistsResult.isNotEmpty) artistSearchResultsWidgets(),
                if (playlistsResult.isNotEmpty) playlistSearchResultsWidgets(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Padding albumSearchResultsWidgets() {
    AlbumsSearchComponent albumsSearchComponent = AlbumsSearchComponent();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Albums",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
                itemCount: albumsResult.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: albumsSearchComponent.albumCard(
                        albumsResult[index], context),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Padding songSearchResultsWidgets() {
    SongsSearchComponent songsSearchComponent = SongsSearchComponent();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Songs",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
                itemCount: songsResult.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: songsSearchComponent.albumCard(
                        songsResult[index], context),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Padding artistSearchResultsWidgets() {
    ArtistsSearchComponent artistsSearchComponent = ArtistsSearchComponent();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Artists",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
                itemCount: artistsResult.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: artistsSearchComponent.albumCard(
                        artistsResult[index], context),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Padding playlistSearchResultsWidgets() {
    PlaylistsSearchComponent artistsSearchComponent =
        PlaylistsSearchComponent();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Playlists",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
                itemCount: playlistsResult.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: artistsSearchComponent.albumCard(
                        playlistsResult[index], context),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
