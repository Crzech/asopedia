import 'package:flutter/material.dart';

class AppCategory {
  final IconData icon;
  final String title;
  final String subtitle;
  final String id;
  final String openBrowser;
  final String slug;

  AppCategory({
    this.openBrowser,
    @required this.slug,
    @required this.icon, 
    @required this.title, 
    @required this.subtitle, 
    @required this.id
  });

  @override
    String toString() {
      return '{"id": "$id", "icon": "${icon.toString()}", "title": "$title", "subtitle": "$subtitle"}';
    }
}