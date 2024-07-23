// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:musix/api/jio.dart';
import 'package:musix/components/album_search_component.dart';
import 'package:musix/components/artist_search_component.dart';
import 'package:musix/components/playlist_search_component.dart';
import 'package:musix/components/songs_search_component.dart';
import 'package:musix/components/specific_artst_playlst_component.dart';
import 'package:musix/components/specific_song_component.dart';
import 'package:musix/models/album_search_model.dart';
import 'package:musix/models/artist_search_response.dart';
import 'package:musix/models/playlist_search_response.dart';
import 'package:musix/models/song_search_response.dart';
import 'package:musix/models/specific_song_result_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

enum SearchOptions { all, songs, artists, albums, playlists }

class _SearchPageState extends State<SearchPage> {
  final searchTextFieldController = TextEditingController();

  List<SongSearchResponse> songsResult = [];
  List<AlbumSearchResponse> albumsResult = [];

  List<ArtistSearchResponse> artistsResult = [];
  List<PlaylistSearchResponse> playlistsResult = [];

  SearchOptions? searchOptions = SearchOptions.all;

  void performAllSearch(String query) {
    JioApi.search(query).then((onValue) {
      setState(() {
        List<dynamic> _albumsResult = onValue['albums']['data'];
        List<dynamic> _songsResult = onValue['songs']['data'];

        List<dynamic> _artistsResult = onValue['artists']['data'];
        List<dynamic> _playlistsResult = onValue['playlists']['data'];

        albumsResult =
            _albumsResult.map((e) => AlbumSearchResponse.fromJson(e)).toList();

        songsResult =
            _songsResult.map((e) => SongSearchResponse.fromJson(e)).toList();

        artistsResult = _artistsResult
            .map((e) => ArtistSearchResponse.fromJson(e))
            .toList();

        playlistsResult = _playlistsResult
            .map((e) => PlaylistSearchResponse.fromJson(e))
            .toList();
      });
    });
  }

  List<SpecificSongResultModel> specificSearchSongResults = [];
  List<SpecificSongResultModel> specificSearchAlbumResults = [];
  List<SpecificSongResultModel> specificSearchArtistResults = [];
  List<SpecificSongResultModel> specificSearchPlaylistResults = [];

  SpecificSongComponent specificSongComponent = SpecificSongComponent();
  SpecificArstPlaylstComponent specificArstPlaylstComponent =
      SpecificArstPlaylstComponent();

  void performSpecificSearch(String query) {
    String searchType = (searchOptions == SearchOptions.songs)
        ? "getResults"
        : (searchOptions == SearchOptions.albums)
            ? "getAlbumResults"
            : (searchOptions == SearchOptions.artists)
                ? "getArtistResults"
                : "getPlaylistResults";
    JioApi.specificSearch(searchType, query).then((onValue) {
      setState(() {
        List<dynamic> results = onValue['results'];

        for (final result in results) {
          if (result['type'] == 'song') {
            specificSearchSongResults.add(
              SpecificSongResultModel(
                songId: result['id'],
                songName: result['title'],
                albumName: result['more_info']['album'],
                art: result['image'],
                artist: result["more_info"]["artistMap"]["primary_artists"]![0]
                    ["name"],
                year: result['year'],
                type: result['type'],
              ),
            );
          } else if (result['type'] == 'album') {
            specificSearchAlbumResults.add(
              SpecificSongResultModel(
                songId: result['id'],
                songName: result['title'],
                albumName: "",
                art: result['image'],
                artist: result["more_info"]["artistMap"]["primary_artists"]![0]
                    ["name"],
                year: result['year'],
                type: result['type'],
              ),
            );
          } else if (result['type'] == 'artist') {
            specificSearchArtistResults.add(
              SpecificSongResultModel(
                songId: result['id'],
                songName: result['name'],
                albumName: "",
                art: result['image'],
                artist: "",
                year: "",
                type: "artist",
              ),
            );
          } else if (result['type'] == 'playlist') {
            specificSearchPlaylistResults.add(
              SpecificSongResultModel(
                songId: result['id'],
                songName: result['title'],
                albumName: "",
                art: result['image'],
                artist: "",
                year: "",
                type: "playlist",
              ),
            );
          }
        }
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
                    } else if (searchOptions == SearchOptions.all) {
                      performAllSearch(searchTextFieldController.text);
                    } else {
                      setState(() {
                        specificSearchAlbumResults.clear();
                        specificSearchArtistResults.clear();
                        specificSearchPlaylistResults.clear();
                        specificSearchSongResults.clear();
                        performSpecificSearch(searchTextFieldController.text);
                      });
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
              )
            ],
          ),
        ),
        searchOptionRadio(),
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                if ((songsResult.isNotEmpty) &&
                    (searchOptions == SearchOptions.all))
                  songSearchResultsWidgets(),
                if ((albumsResult.isNotEmpty) &&
                    (searchOptions == SearchOptions.all))
                  albumSearchResultsWidgets(),
                if ((artistsResult.isNotEmpty) &&
                    (searchOptions == SearchOptions.all))
                  artistSearchResultsWidgets(),
                if ((playlistsResult.isNotEmpty) &&
                    (searchOptions == SearchOptions.all))
                  playlistSearchResultsWidgets(),
                if ((specificSearchSongResults.isNotEmpty) &&
                    (searchOptions == SearchOptions.songs))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 900, child: specificSongsWidgets(context)),
                  ),
                if ((specificSearchAlbumResults.isNotEmpty) &&
                    (searchOptions == SearchOptions.albums))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 900, child: specificAlbumsWidgets(context)),
                  ),
                if ((specificSearchArtistResults.isNotEmpty) &&
                    (searchOptions == SearchOptions.artists))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 900, child: specificArtistsWidgets(context)),
                  ),
                if ((specificSearchPlaylistResults.isNotEmpty) &&
                    (searchOptions == SearchOptions.playlists))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 900, child: specificPlaylistsWidgets(context)),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }

  GridView specificPlaylistsWidgets(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (MediaQuery.of(context).size.width ~/ 250).toInt(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
        ),
        itemCount: specificSearchPlaylistResults.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final songItem_ = specificSearchPlaylistResults[index];
          return specificArstPlaylstComponent.albumCard(songItem_, context);
        });
  }

  GridView specificArtistsWidgets(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (MediaQuery.of(context).size.width ~/ 250).toInt(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
        ),
        itemCount: specificSearchArtistResults.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final songItem_ = specificSearchArtistResults[index];
          return specificArstPlaylstComponent.albumCard(songItem_, context);
        });
  }

  GridView specificAlbumsWidgets(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (MediaQuery.of(context).size.width ~/ 250).toInt(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
        ),
        itemCount: specificSearchAlbumResults.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final songItem_ = specificSearchAlbumResults[index];
          return specificSongComponent.albumCard(songItem_, context);
        });
  }

  GridView specificSongsWidgets(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (MediaQuery.of(context).size.width ~/ 250).toInt(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 5,
        ),
        itemCount: specificSearchSongResults.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final songItem_ = specificSearchSongResults[index];
          return specificSongComponent.albumCard(songItem_, context);
        });
  }

  SingleChildScrollView searchOptionRadio() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: 117,
            child: RadioListTile<SearchOptions>(
                value: SearchOptions.all,
                groupValue: searchOptions,
                title: const Text("All"),
                onChanged: (SearchOptions? value) {
                  setState(() {
                    searchOptions = value;
                  });
                }),
          ),
          SizedBox(
            width: 144,
            child: RadioListTile<SearchOptions>(
                value: SearchOptions.songs,
                groupValue: searchOptions,
                title: const Text("Songs"),
                onChanged: (SearchOptions? value) {
                  setState(() {
                    searchOptions = value;
                  });
                }),
          ),
          SizedBox(
            width: 160,
            child: RadioListTile<SearchOptions>(
                value: SearchOptions.albums,
                groupValue: searchOptions,
                title: const Text("Albums"),
                onChanged: (SearchOptions? value) {
                  setState(() {
                    searchOptions = value;
                  });
                }),
          ),
          SizedBox(
            width: 150,
            child: RadioListTile<SearchOptions>(
                value: SearchOptions.artists,
                groupValue: searchOptions,
                title: const Text("Artists"),
                onChanged: (SearchOptions? value) {
                  setState(() {
                    searchOptions = value;
                  });
                }),
          ),
          SizedBox(
            width: 170,
            child: RadioListTile<SearchOptions>(
                value: SearchOptions.playlists,
                groupValue: searchOptions,
                title: const Text("Playlists"),
                onChanged: (SearchOptions? value) {
                  setState(() {
                    searchOptions = value;
                  });
                }),
          )
        ],
      ),
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
