import 'package:meta/meta.dart';
import 'dart:convert';

class SearchResult {
  SearchResult({
    @required this.id,
    @required this.title,
    @required this.url,
  });

  int id;
  String title;
  String url;

  factory SearchResult.fromRawJson(String str) => SearchResult.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
    id: json["id"],
    title: json["title"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
  };
}
