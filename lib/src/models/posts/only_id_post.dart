import 'package:asopedia/src/models/posts/abstract_post.dart';

import 'package:meta/meta.dart';

class OnlyIdPost extends AbstractPost {
  OnlyIdPost({ @required this.id });
  final int id;
}