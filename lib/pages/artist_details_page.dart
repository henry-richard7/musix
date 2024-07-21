import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musix/api/jio.dart';
import 'package:musix/components/top_songs_component.dart';

class ArtistDetailsPage extends StatefulWidget {
  const ArtistDetailsPage({super.key, required this.artistId});
  final String artistId;

  @override
  State<ArtistDetailsPage> createState() => _ArtistDetailsPageState();
}

class _ArtistDetailsPageState extends State<ArtistDetailsPage> {
  List<dynamic> topSongs = [];
  List<dynamic> topAlbums = [];

  Map<String, dynamic> fullResponse = {};

  TopSongsComponent topSongsComponent = TopSongsComponent();

  bool isLoaded = false;
  @override
  void initState() {
    super.initState();

    JioApi.artistDetails(widget.artistId).then((onValue) {
      setState(() {
        fullResponse = onValue;
        topSongs = onValue["topSongs"]["songs"];
        topAlbums = onValue["topAlbums"]["albums"];

        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("MusicX - Artist Details"),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              (Navigator.pop(context));
            },
          ),
        ),
        body: (isLoaded)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: artistMeta(),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Top Songs",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          topSongsWidget(
                            topSongs: topSongs,
                            topSongsComponent: topSongsComponent,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Top Albums",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          topSongsWidget(
                            topSongs: topAlbums,
                            topSongsComponent: topSongsComponent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }

  Wrap artistMeta() {
    return Wrap(
      children: [
        Image.network(
          fullResponse['image'].toString().replaceAll("150x150", "500x500"),
          filterQuality: FilterQuality.high,
          height: 260,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullResponse['name'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Follower Count: ${fullResponse['follower_count']}",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                fullResponse['subtitle'],
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class topSongsWidget extends StatelessWidget {
  const topSongsWidget({
    super.key,
    required this.topSongs,
    required this.topSongsComponent,
  });

  final List topSongs;
  final TopSongsComponent topSongsComponent;

  @override
  Widget build(BuildContext context) {
    String albumData;
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topSongs.length,
        itemBuilder: (context, index) {
          if (topSongs[index]['type'] == 'song') {
            albumData = topSongs[index]['more_info']['album'];
          } else {
            albumData = topSongs[index]['more_info']['artistMap']
                ['primary_artists'][0]['name'];
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: topSongsComponent.topSongCard(
                topSongs[index]['id'],
                topSongs[index]['title'],
                topSongs[index]['image'],
                topSongs[index]['year'],
                albumData,
                topSongs[index]['type'],
                context),
          );
        },
      ),
    );
  }
}
