import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:flutter/material.dart';

class PostLoader extends StatelessWidget {
  const PostLoader({
    @required this.posts,
    @required this.isLoading, 
  });

  final List<AbstractPost> posts;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: posts.length > 1 ? MainAxisAlignment.end : MainAxisAlignment.center,
          children: [
            isLoading ? CircularProgressIndicator() : Container(),
            SizedBox(height: 20)
          ],
        ),
      ],
    );
  }
}