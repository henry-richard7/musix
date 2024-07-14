import 'package:flutter/material.dart';
import 'package:musix/api/jio.dart';
import 'package:musix/components/album_search_component.dart';
import 'package:musix/models/album_search_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchTextFieldController = TextEditingController();

  List<dynamic> songsResult = [];
  List<AlbumSearchResponse> albumsResult = [];
  List<dynamic> artistsResult = [];
  List<dynamic> playlistsResult = [];

  void performSearch(String query) {
    JioApi.search(query).then((onValue) {
      setState(() {
        List<dynamic> _albumsResult = onValue['albums']['data'];
        albumsResult =
            _albumsResult.map((e) => AlbumSearchResponse.fromJson(e)).toList();
        songsResult = onValue['songs']['data'];
        //albumsResult = onValue['albums']['data'];
        artistsResult = onValue['artists']['data'];
        playlistsResult = onValue['playlists']['data'];
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
        if (albumsResult.isNotEmpty) albumSearchResultsWidgets()
      ],
    );
  }

  Column albumSearchResultsWidgets() {
    AlbumsSearchComponent albumsSearchComponent = AlbumsSearchComponent();
    return Column(
      children: [
        const Text("Albums"),
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
    );
  }
}
