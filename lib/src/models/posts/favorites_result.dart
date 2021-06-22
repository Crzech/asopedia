import 'package:asopedia/src/models/posts/glossary_post.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class FavoritesResult {
    FavoritesResult({
        @required this.id,
        @required this.title,
        @required this.created,
    });

    int id;
    RenderedField title;
    DateTime created;

    factory FavoritesResult.fromRawJson(String str) => FavoritesResult.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FavoritesResult.fromJson(Map<String, dynamic> json) => FavoritesResult(
        id: json["id"],
        title: RenderedField.fromJson(json["title"]),
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title.toJson(),
        "created": created.toIso8601String(),
    };
}