import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dart_des/dart_des.dart';

class JioApi {
  static const String jioApiBase = "https://www.jiosaavn.com/api.php";

  static String decryptUrl(String url) {
    final encUrl = base64Decode(url);
    const key = '38346591';

    final desCipher = DES(
        key: key.codeUnits,
        mode: DESMode.ECB,
        iv: List.filled(8, 0),
        paddingType: DESPaddingType.PKCS5);
    final decUrl = utf8.decode(desCipher.decrypt(encUrl));
    return decUrl.replaceAll('_96.mp4', '_320.mp4');
  }

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
      "_format": "json",
      "_marker": "0",
      "cc": "in",
      "includeMetaTags": "1",
      "query": query,
    };

    Uri searchPageUrl =
        Uri.parse(jioApiBase).replace(queryParameters: queryParameters);

    var request = await http.get(searchPageUrl);
    Map<String, dynamic> decodedResponse = jsonDecode(request.body);

    return decodedResponse;
  }

  static Future<Map<String, dynamic>> artistDetails(String artistId) async {
    Map<String, dynamic> queryParameters = {
      "__call": "artist.getArtistPageDetails",
      "_format": "json",
      "_marker": "0",
      "api_version": "4",
      "sort_by": "latest",
      "sortOrder": "desc",
      "artistId": artistId,
    };

    Uri artistPageUrl =
        Uri.parse(jioApiBase).replace(queryParameters: queryParameters);

    var request = await http.get(artistPageUrl);
    Map<String, dynamic> decodedResponse = jsonDecode(request.body);

    return decodedResponse;
  }

  static Future<Map<String, dynamic>> songDetail(String songId) async {
    Map<String, dynamic> queryParameters = {
      "__call": "song.getDetails",
      "cc": "in",
      "pids": songId,
      "_format": "json",
      "_marker": "0",
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
