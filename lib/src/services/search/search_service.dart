import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:asopedia/src/models/posts/glossary_post.dart';
import 'package:asopedia/src/util/user_preferences.dart';
import 'package:asopedia/src/util/login_exception.dart';
class SearchService {

  static Future<List<GlossaryPost>> getSearchResults(String query, String categoryId) async {
    UserPreferences _prefs = UserPreferences();
    Map<String, String> _params = {
      'search': query,
      'categories': categoryId,
      '_embed': 'true'
    };
    final response = await http.get(
      Uri.https('sgc.asopedia.com', '/wp-json/wp/v2/posts', _params),
      headers: <String, String> {
        'Authorization': 'Bearer ${_prefs.token}',
        'Content-Type': 'application/json; charset=UTF-8'
      }
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
        .map((e) => GlossaryPost.fromJson(Map<String, dynamic>.from(e))).toList();
    } else {
      throw LoginException('Los servidores no estan funcionando, inténtelo de nuevo');
    }
  } 

}