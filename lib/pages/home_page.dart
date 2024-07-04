import 'package:flutter/material.dart';
import 'package:musix/api/jio.dart';
import 'package:musix/components/albums_component.dart';
import 'package:musix/models/charts_model.dart';
import 'package:musix/models/featured_playlist.dart';
import 'package:musix/models/home_albums.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AlbumsComponent albumsComponent = AlbumsComponent();

  List<HomeAlbums> homeAlbums = [];
  List<FeaturedPlaylists> featuredPlaylists = [];
  List<Charts> charts = [];

  bool isAlbumLoaded = false;

  @override
  void initState() {
    JioApi.homePage("tamil").then((onValue) {
      List<dynamic> newAlbums = onValue['new_albums'];
      List<dynamic> featuredPlaylistsRaw = onValue['featured_playlists'];
      List<dynamic> chartsRaw = onValue['charts'];

      setState(() {
        homeAlbums = newAlbums
            .map((toElement) => HomeAlbums.fromJson(toElement))
            .toList();

        isAlbumLoaded = true;

        featuredPlaylists = featuredPlaylistsRaw
            .map((toElement) => FeaturedPlaylists.fromJson(toElement))
            .toList();

        charts =
            chartsRaw.map((toElement) => Charts.fromJson(toElement)).toList();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "New Albums",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
              itemCount: homeAlbums.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: albumsComponent.albumCard(homeAlbums[index], context),
                );
              }),
        )
      ],
    );
  }
}
