import 'package:asopedia/src/models/posts/glossary_post.dart';
import 'package:asopedia/src/models/posts/content.dart';

abstract class AbstractPost {
  int id;
  RenderedField title;
  DateTime date;
  Content content;
}