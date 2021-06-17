import 'package:flutter/material.dart';
import 'dart:convert';

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