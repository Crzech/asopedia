import 'package:meta/meta.dart';
import 'dart:convert';

class MainCategory {
  MainCategory({
    @required this.id,
    @required this.title,
  });

  int id;
  String title;

  factory MainCategory.fromRawJson(String str) =>
      MainCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MainCategory.fromJson(Map<String, dynamic> json) => MainCategory(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
