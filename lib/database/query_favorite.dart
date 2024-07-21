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

  Iterable<dynamic> getAllFavorites() {
    var favoriteBox = Hive.box('favorites');
    Iterable<dynamic> allFavoriteItems = favoriteBox.values;

    return allFavoriteItems;
  }

  void removeFavorite(
    String songId,
  ) {
    var favoriteBox = Hive.box('favorites');
    favoriteBox.delete(songId);
  }
}
