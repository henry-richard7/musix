import 'package:flutter/material.dart';
import 'package:musix/database/query_favorite.dart';
import 'package:musix/pages/music_player_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    QueryFavorite queryFavorite = QueryFavorite();

    var allFavorites = queryFavorite.getAllFavorites();
    return Column(
      children: [
        albumSongs(allFavorites),
      ],
    );
  }

  Expanded albumSongs(Iterable<dynamic> favoriteItem) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: favoriteItem.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  child: ListTile(
                    title: Text(
                      favoriteItem.elementAt(index).songName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      favoriteItem.elementAt(index).primaryArtists,
                      style: const TextStyle(fontSize: 14),
                    ),
                    leading: Image.network(
                      favoriteItem.elementAt(index).art,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MusicPlayerPage(
                          songId: favoriteItem.elementAt(index).songId,
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
