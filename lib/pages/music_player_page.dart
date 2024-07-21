import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musix/adapters/favorite.dart';
import 'package:musix/api/jio.dart';
import 'package:musix/components/common.dart';
import 'package:musix/components/music_player_controls.dart';
import 'package:musix/database/query_favorite.dart';
import 'package:rxdart/rxdart.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({super.key, required this.songId});
  final String songId;

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  Map<String, dynamic> songDetails = {};
  String songUrl = "";
  bool isLoaded = false;
  AudioPlayer audioPlayer = AudioPlayer();

  QueryFavorite queryFavorite = QueryFavorite();
  @override
  void initState() {
    super.initState();
    JioApi.songDetail(widget.songId).then((onValue) => {
          setState(() {
            songDetails = onValue[widget.songId];
            songUrl = JioApi.decryptUrl(
                onValue[widget.songId]['encrypted_media_url']);
            isLoaded = true;
            audioPlayer.setUrl(songUrl);
          })
        });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: const Text("MusicX"),
                titleTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 20),
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
            body: (isLoaded)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Your Now Playing",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              HtmlUnescape().convert(songDetails['album']),
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            width: 280,
                            height: 280,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  songDetails['image']
                                      .toString()
                                      .replaceAll("150x150", "500x500"),
                                ),
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.high,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                          ),
                          Wrap(
                            //mainAxisAlignment: MainAxisAlignment.center,\
                            alignment: WrapAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      HtmlUnescape()
                                          .convert(songDetails['song']),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    HtmlUnescape().convert(
                                        songDetails['primary_artists']),
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  if (queryFavorite
                                          .getFavorite(widget.songId) ==
                                      null) {
                                    setState(() {
                                      FavoriteItem newFavorite = FavoriteItem(
                                          songId: widget.songId,
                                          songName: HtmlUnescape()
                                              .convert(songDetails['song']),
                                          albumName: HtmlUnescape()
                                              .convert(songDetails['album']),
                                          art: songDetails['image']
                                              .toString()
                                              .replaceAll("150x150", "500x500"),
                                          primaryArtists: HtmlUnescape()
                                              .convert(songDetails[
                                                  'primary_artists']),
                                          streamLink: songUrl);

                                      queryFavorite.addFavorite(
                                          widget.songId, newFavorite);
                                    });
                                  } else {
                                    setState(() {
                                      queryFavorite
                                          .removeFavorite(widget.songId);
                                    });
                                  }
                                },
                                icon: (queryFavorite
                                            .getFavorite(widget.songId) ==
                                        null)
                                    ? const Icon(Icons.favorite_border_outlined)
                                    : const Icon(Icons.favorite),
                                iconSize: 30.0,
                              )
                            ],
                          ),
                          StreamBuilder<PositionData>(
                            stream: _positionDataStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data;
                              return SeekBar(
                                duration:
                                    positionData?.duration ?? Duration.zero,
                                position:
                                    positionData?.position ?? Duration.zero,
                                bufferedPosition:
                                    positionData?.bufferedPosition ??
                                        Duration.zero,
                                onChangeEnd: audioPlayer.seek,
                              );
                            },
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MusicPlayerControls(
                                player: audioPlayer,
                              ))
                        ],
                      ),
                    ),
                  )
                : const CircularProgressIndicator()));
  }
}
