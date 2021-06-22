import 'package:flutter/material.dart';

class AppCategory {
  final IconData icon;
  final String title;
  final String subtitle;
  final String id;

  AppCategory({
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