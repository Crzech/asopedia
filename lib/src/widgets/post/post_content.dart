import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:asopedia/src/models/posts/content.dart';

class PostContent extends StatelessWidget {
  const PostContent({
    @required this.content,
  });

  final Content content;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Html(data: content.rendered),
      ),
    );
  }
}