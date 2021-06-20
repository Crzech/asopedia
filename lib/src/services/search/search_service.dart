import 'dart:convert';

import 'package:asopedia/src/util/login_exception.dart';
import 'package:http/http.dart' as http;

import 'package:asopedia/src/models/search/search_result.dart';
import 'package:asopedia/src/util/user_preferences.dart';

class SearchService {

  static Future<List<SearchResult>> getSearchResults(String query) async {
    UserPreferences _prefs = UserPreferences();
    Map<String, String> _params = {
      'search': query,
      'subtype': 'post'
    };
    final response = await http.get(
      Uri.https('sgc.asopedia.com', '/wp-json/wp/v2/search', _params),
      headers: <String, String> {
        'Authorization': 'Bearer ${_prefs.token}',
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
        .map((e) => SearchResult.fromJson(Map<String, dynamic>.from(e))).toList();
    } else {
      throw LoginException('Los servidores no estan funcionando, inténtelo de nuevo');
    }
  } 

}