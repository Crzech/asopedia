import 'package:flutter/material.dart';

class PostsAppBar extends StatelessWidget {
  const PostsAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
          onTap: () => Navigator.of(context).pop(),
        ),
        Text('Glosario', style: TextStyle(color: Colors.white, fontSize: 20.0)),
        Icon(Icons.search, color: Colors.white)
      ],
    );
  }
}