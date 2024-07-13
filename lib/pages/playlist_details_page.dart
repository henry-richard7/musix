import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musix/api/jio.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:musix/pages/music_player_page.dart';

class PlaylistDetailsPage extends StatefulWidget {
  const PlaylistDetailsPage({super.key, required this.playlistId});
  final String playlistId;

  @override
  State<PlaylistDetailsPage> createState() => _PlaylistDetailsPageState();
}

class _PlaylistDetailsPageState extends State<PlaylistDetailsPage> {
  Map<String, dynamic> playlistDetailsResponse = {};
  List<dynamic> songs = [];
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    JioApi.playlistDetail(widget.playlistId).then((onValue) => {
          setState(() {
            playlistDetailsResponse = onValue;
            songs = onValue['songs'];
            isLoaded = true;
          })
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
            title: const Text("MusicX - Playlist Details"),
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
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (isLoaded)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    albumDetailWidgets(),
                    albumSongs(),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  Wrap albumDetailWidgets() {
    return Wrap(
      children: [
        Image.network(
          playlistDetailsResponse['image']
              .toString()
              .replaceAll("150x150", "500x500"),
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
                playlistDetailsResponse['listname'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Followers: ${playlistDetailsResponse['follower_count']}",
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

  Expanded albumSongs() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: songs.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  child: ListTile(
                    title: Text(
                      HtmlUnescape().convert(
                        songs[index]['song'].toString(),
                      ),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          HtmlUnescape().convert(
                            songs[index]['album'].toString(),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                        Text(
                          HtmlUnescape().convert(
                            songs[index]['primary_artists'].toString(),
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    leading: Image.network(
                      songs[index]['image']
                          .toString()
                          .replaceAll("150x150", "500x500"),
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  onTap: () {
                    var songId = songs[index]['id'];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPlayerPage(
                          songId: songId,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
