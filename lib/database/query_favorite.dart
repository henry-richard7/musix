import 'package:musix/adapters/favorite.dart';
import 'package:hive_flutter/hive_flutter.dart';

class QueryFavorite {
  void addFavorite(
    String songId,
    FavoriteItem? favoriteModel,
  ) {
    var favoriteBox = Hive.box('favorites');
    favoriteBox.put(songId, favoriteModel);
  }

  FavoriteItem? getFavorite(String songId) {
    var favoriteBox = Hive.box('favorites');
    FavoriteItem? favoriteModel = favoriteBox.get(songId);
    return favoriteModel;
  }
}
