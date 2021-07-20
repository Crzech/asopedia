import 'package:flutter/material.dart';

import 'package:asopedia/src/models/posts/post_image.dart';
import 'package:asopedia/src/widgets/shared/sliver_header_delegate.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    @required this.screenSize, 
    @required this.title, 
    @required this.datetime, 
    @required this.embedeData,
  });
  
  final Size screenSize;
  final String title;
  final DateTime datetime;
  final EmbedeData embedeData;

  @override
  Widget build(BuildContext context) {
    final wpFeaturedMedia = embedeData != null 
      ? embedeData.wpFeaturedmedia.length >= 1 ? embedeData.wpFeaturedmedia[0] : null
      : null;
    final imageUrl = wpFeaturedMedia?.mediaDetails?.sizes?.full?.sourceUrl;

    return SliverPersistentHeader(
      floating: true,
      delegate: SliverHeaderCustomHeaderDelegate(
        minHeight: screenSize.height * 0.40,
        maxHeight: screenSize.height * 0.50,
        child: Container(
          decoration: imageUrl == null 
            ? BoxDecoration(color: Color(0xff155682))
            : BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(imageUrl)
              )
            ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 25),
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(height: 20.0)
                ]
              ),
            ),
          ),
        )
      ),
    );
  }
}