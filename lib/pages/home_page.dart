import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musix/api/jio.dart';
import 'package:musix/components/albums_component.dart';
import 'package:musix/components/chart_component.dart';
import 'package:musix/components/playlist_component.dart';
import 'package:musix/models/charts_model.dart';
import 'package:musix/models/featured_playlist.dart';
import 'package:musix/models/home_albums.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final List<String> languages = ["Tamil", "English", "Hindi", ""];
  String selectedLanguage = languages.first.toString();

  AlbumsComponent albumsComponent = AlbumsComponent();
  ChartComponent chartComponent = ChartComponent();
  PlaylistComponent playlistComponent = PlaylistComponent();

  List<HomeAlbums> homeAlbums = [];
  List<FeaturedPlaylists> featuredPlaylists = [];
  List<Charts> charts = [];

  bool isAlbumLoaded = false;

  void callData() {
    JioApi.homePage(selectedLanguage.toLowerCase()).then((onValue) {
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
  }

  @override
  void initState() {
    super.initState();
    callData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      home: Scaffold(
        appBar: AppBar(
            title: const Text("MusicX"),
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            backgroundColor: Colors.blue,
            actions: [
              DropdownMenu(
                initialSelection: selectedLanguage,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    selectedLanguage = value!;
                    callData();
                  });
                },
                dropdownMenuEntries:
                    languages.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            ]),
        body: mainContent(),
      ),
    );
  }

  SingleChildScrollView mainContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "New Albums",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          albumsWidget(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Top Charts",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          topChartsWidgets(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Top Playlists",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
                itemCount: featuredPlaylists.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: playlistComponent.playlistComponent(
                        featuredPlaylists[index], context),
                  );
                }),
          ),
        ],
      ),
    );
  }

  SizedBox topChartsWidgets() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
          itemCount: charts.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: chartComponent.chartComponent(charts[index], context),
            );
          }),
    );
  }

  SizedBox albumsWidget() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
          itemCount: homeAlbums.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: albumsComponent.albumCard(homeAlbums[index], context),
            );
          }),
    );
  }
}
