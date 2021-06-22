import 'dart:convert';
import 'package:asopedia/src/models/categories/app_category.dart';
import 'package:asopedia/src/util/category_mapper.dart';
import 'package:http/http.dart' as http;

import 'package:asopedia/src/util/login_exception.dart';
import 'package:asopedia/src/util/user_preferences.dart';
import 'package:asopedia/src/models/categories/category.dart';
import 'package:asopedia/src/models/shared/dropdown_item.dart';

// const List<Map<String, dynamic>> mockCategories = [
//   {"id": 1, "title": "Revista"},
//   {"id": 2, "title": "Social"},
//   {"id": 3, "title": 'Congresos'},
//   {"id": 4, "title": "Eventos"}
// ];

Future<List<DropdownItem>> getChildCategories(String parentCategory) async {
  UserPreferences _prefs = UserPreferences();
  final response = await http.get(
    Uri.https('sgc.asopedia.com', 'wp-json/wp/v2/categories', { 'parent': parentCategory }),
    headers: <String, String>{
      'Authorization': 'Bearer ${_prefs.token}',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    final categories = (jsonDecode(response.body) as List)
        .map((e) => Category.fromJson(e))
        .toList();

    return categories
      .map((e) => DropdownItem(id: e.id.toString(), title: e.name))
      .toList();
  } else {
    throw LoginException('Los servidores no estan funcionando, inténtelo de nuevo');
  }
}

Future<List<AppCategory>> getParentCategories() async {
  UserPreferences _prefs = UserPreferences();
  final response = await http.get(
    Uri.https('sgc.asopedia.com', 'wp-json/wp/v2/categories', { 'parent': '0' }),
    headers: <String, String> {
      'Authorization': 'Bearer ${_prefs.token}',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as List)
      .map((e) => Category.fromJson(e))
      .map((cat) => CategoryMapper.getCategoryProperties(cat))
      .toList();
  } else {
    throw LoginException('Los servidores no estan funcionando, inténtelo de nuevo');
  }
}
