import 'dart:convert';
import 'package:asopedia/src/util/login_exception.dart';
import 'package:asopedia/src/util/user_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:asopedia/src/models/posts/glossary_post.dart';

class PostService {
  static Future<List<GlossaryPost>> getPostsByCategoryId(String categoryId, int pageKey, int pageSize) async {
    UserPreferences _prefs = UserPreferences();
    Map<String, dynamic> params = { 
        'categories': categoryId, 
        'order': 'asc',
        'per_page': pageSize.toString(),
        'page': pageKey.toString()
    };
    print(params);
    final response = await http.get(
      Uri.https('sgc.asopedia.com', 'wp-json/wp/v2/posts', { 
        'categories': categoryId, 
        'order': 'asc',
        'per_page': pageSize.toString(),
        'page': pageKey.toString()
      }),
      headers: <String, String> {
        'Authorization': 'Bearer ${_prefs.token}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((e) => GlossaryPost.fromJson(
        Map<String, dynamic>.from(e)
      )).toList();
    } else if (response.statusCode == 400) {
      return [];
    } else {
      print(response.body);
      throw LoginException('Los servidores no estan funcionando, inténtelo de nuevo');
    }
  }
}