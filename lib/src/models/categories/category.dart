import 'package:meta/meta.dart';
import 'dart:convert';

class Category {
    Category({
        @required this.id,
        @required this.count,
        @required this.description,
        @required this.link,
        @required this.name,
        @required this.slug,
        @required this.taxonomy,
        @required this.parent,
        @required this.meta,
    });

    int id;
    int count;
    String description;
    String link;
    String name;
    String slug;
    String taxonomy;
    int parent;
    List<dynamic> meta;

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        count: json["count"],
        description: json["description"],
        link: json["link"],
        name: json["name"],
        slug: json["slug"],
        taxonomy: json["taxonomy"],
        parent: json["parent"],
        meta: List<dynamic>.from(json["meta"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
        "description": description,
        "link": link,
        "name": name,
        "slug": slug,
        "taxonomy": taxonomy,
        "parent": parent,
        "meta": List<dynamic>.from(meta.map((x) => x)),
    };
}