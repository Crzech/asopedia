import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class GlossaryPost extends AbstractPost {
  GlossaryPost({
    @required this.id,
    @required this.date,
    @required this.dateGmt,
    @required this.guid,
    @required this.modified,
    @required this.modifiedGmt,
    @required this.slug,
    @required this.status,
    @required this.type,
    @required this.link,
    @required this.title,
    @required this.content,
  });

  int id;
  DateTime date;
  DateTime dateGmt;
  RenderedField guid;
  DateTime modified;
  DateTime modifiedGmt;
  String slug;
  String status;
  String type;
  String link;
  RenderedField title;
  Content content;

  factory GlossaryPost.fromRawJson(String str) => GlossaryPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GlossaryPost.fromJson(Map<String, dynamic> json) => GlossaryPost(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        dateGmt: DateTime.parse(json["date_gmt"]),
        guid: RenderedField.fromJson(json["guid"]),
        modified: DateTime.parse(json["modified"]),
        modifiedGmt: DateTime.parse(json["modified_gmt"]),
        slug: json["slug"],
        status: json["status"],
        type: json["type"],
        link: json["link"],
        title: RenderedField.fromJson(json["title"]),
        content: Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "date_gmt": dateGmt.toIso8601String(),
        "guid": guid.toJson(),
        "modified": modified.toIso8601String(),
        "modified_gmt": modifiedGmt.toIso8601String(),
        "slug": slug,
        "status": status,
        "type": type,
        "link": link,
        "title": title.toJson(),
        "content": content.toJson(),
      };
}

class Content {
  Content({
    @required this.rendered,
    @required this.protected,
  });

  String rendered;
  bool protected;

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        rendered: json["rendered"],
        protected: json["protected"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
        "protected": protected,
      };
}

class RenderedField {
  RenderedField({
    @required this.rendered,
  });

  String rendered;

  factory RenderedField.fromRawJson(String str) => RenderedField.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RenderedField.fromJson(Map<String, dynamic> json) => RenderedField(
        rendered: json["rendered"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
      };
}
