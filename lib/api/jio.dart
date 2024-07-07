import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

class JioApi {
  static const String jioApiBase = "https://www.jiosaavn.com/api.php";
  static final key = encrypt.Key.fromUtf8('38346591');
  static final iv = encrypt.IV.fromLength(8);

  static Future<Map<String, dynamic>> homePage(String language) async {
    Map<String, dynamic> queryParameters = {
      "__call": "content.getHomepageData"
    };
    var headers = {"Cookie": "L=$language;"};
    Uri homePageUrl =
        Uri.parse(jioApiBase).replace(queryParameters: queryParameters);

    var request = await http.get(homePageUrl, headers: headers);
    Map<String, dynamic> decodedResponse = jsonDecode(request.body);

    return decodedResponse;
  }

  static Future<Map<String, dynamic>> albumDetails(String albumId) async {
    Map<String, dynamic> queryParameters = {
      "__call": "content.getAlbumDetails",
      "albumid": albumId,
    };

    Uri albumPageUrl =
        Uri.parse(jioApiBase).replace(queryParameters: queryParameters);

    var request = await http.get(albumPageUrl);
    Map<String, dynamic> decodedResponse = jsonDecode(request.body);

    return decodedResponse;
  }

  static Future<Map<String, dynamic>> search(String query) async {
    Map<String, dynamic> queryParameters = {
      "__call": "autocomplete.get",
      "query": query,
      "ctx": "android",
      "_format": "json",
      "_marker": 0,
    };

    Uri searchPageUrl =
        Uri.parse(jioApiBase).replace(queryParameters: queryParameters);

    var request = await http.get(searchPageUrl);
    Map<String, dynamic> decodedResponse = jsonDecode(request.body);

    return decodedResponse;
  }

  static Future<Map<String, dynamic>> songDetail(String songId) async {
    Map<String, dynamic> queryParameters = {
      "__call": "song.getDetails",
      "cc": "in",
      "pids": songId,
      "_format": "json",
      "_marker": 0,
    };

    Uri searchPageUrl =
        Uri.parse(jioApiBase).replace(queryParameters: queryParameters);

    var request = await http.get(searchPageUrl);
    Map<String, dynamic> decodedResponse = jsonDecode(request.body);

    return decodedResponse;
  }

  static Future<Map<String, dynamic>> playlistDetail(String listId) async {
    Map<String, dynamic> queryParameters = {
      "__call": "playlist.getDetails",
      "cc": "in",
      "listid": listId,
      "_format": "json",
      "_marker": "0",
    };

    Uri searchPageUrl =
        Uri.parse(jioApiBase).replace(queryParameters: queryParameters);

    var request = await http.get(searchPageUrl);
    Map<String, dynamic> decodedResponse = jsonDecode(request.body);

    return decodedResponse;
  }
}
