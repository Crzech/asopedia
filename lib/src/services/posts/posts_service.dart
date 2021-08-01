import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:asopedia/src/models/posts/glossary_post.dart';
import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/models/posts/favorites_result.dart';
import 'package:asopedia/src/util/login_exception.dart';
import 'package:asopedia/src/util/user_preferences.dart';

class PostService {
  static Future<List<GlossaryPost>> getLatestPosts() async {
    UserPreferences _prefs = UserPreferences();
    Map<String, dynamic> params = {
      'order': 'desc',
      'limit': '10',
      '_embed': 'true',
      'categories_exclude': '77,1'
    };
    final response = await http.get(
      Uri.https('asopedia.com', 'wp-json/wp/v2/posts', params),
      headers: <String, String>{
        'Authorization': 'Bearer ${_prefs.token}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => GlossaryPost.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } else if (response.statusCode == 400) {
      return [];
    } else {
      throw LoginException(
          'Los servidores no estan funcionando, inténtelo de nuevo');
    }
  }

  static Future<List<GlossaryPost>> getPostsByCategoryId(
      String categoryId, int pageKey, int pageSize) async {
    UserPreferences _prefs = UserPreferences();
    Map<String, dynamic> params = {
      'categories': categoryId,
      'order': 'desc',
      'per_page': pageSize.toString(),
      'page': pageKey.toString(),
      'categories_exclude': '1'
    };
    final response = await http.get(
      Uri.https('asopedia.com', 'wp-json/wp/v2/posts', params),
      headers: <String, String>{
        'Authorization': 'Bearer ${_prefs.token}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((e) => GlossaryPost.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } else if (response.statusCode == 400) {
      print(params);
      return [];
    } else {
      throw LoginException(
          'Los servidores no estan funcionando, inténtelo de nuevo');
    }
  }

  static Future<GlossaryPost> getPostsById(int postId) async {
    UserPreferences _prefs = UserPreferences();
    final response = await http.get(
        Uri.https('asopedia.com', 'wp-json/wp/v2/posts/$postId',
            {'_embed': 'true'}),
        headers: <String, String>{
          'Authorization': 'Bearer ${_prefs.token}',
          'Content-Type': 'application/json; charset=UTF-8',
        });

    try {
      if (response.statusCode == 200) {
        return GlossaryPost.fromRawJson(response.body);
      } else {
        throw LoginException(
            'Los servidores no estan funcionando, inténtelo de nuevo');
      }
    } catch (ex) {
      throw LoginException(
          'Los servidores no estan funcionando, inténtelo de nuevo');
    }
  }

  static Future<bool> addToFavorites(AbstractPost post) async {
    UserPreferences _prefs = UserPreferences();
    final response = await http.post(
        Uri.https('asopedia.com', 'wp-json/user/favorites'),
        headers: <String, String>{
          'Authorization': 'Bearer ${_prefs.token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id': post.id,
          'title': post.title,
          'created': post.date.toString()
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw LoginException(
          'Los servidores no estan funcionando, inténtelo de nuevo');
    }
  }

  static Future<bool> removeFromFavorites(AbstractPost post) async {
    UserPreferences _prefs = UserPreferences();
    final response = await http.delete(
      Uri.https('asopedia.com', 'wp-json/user/favorites/${post.id}'),
      headers: <String, String>{
        'Authorization': 'Bearer ${_prefs.token}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw LoginException(
          'Los servidores no estan funcionando, inténtelo de nuevo');
    }
  }

  static Future<List<FavoritesResult>> getFavorites() async {
    UserPreferences _prefs = UserPreferences();
    final response = await http.get(
        Uri.https('asopedia.com', 'wp-json/user/favorites'),
        headers: <String, String>{
          'Authorization': 'Bearer ${_prefs.token}',
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      final dataList = (jsonDecode(response.body) as List);
      if (dataList.length > 0) {
        return (dataList[0]['favorites'] as List).map((e) => FavoritesResult.fromJson(e)).toList();
      } 
      return [];
    } else {
      throw LoginException(
          'Los servidores no estan funcionando, inténtelo de nuevo');
    }
  }
}
