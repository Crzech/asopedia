
// import 'package:asopedia/src/models/posts/glossary_post.dart';
import 'package:asopedia/src/models/posts/post_image.dart';

String getPostImage(EmbedeData embedeData) {
  final wpFeaturedMedia = embedeData != null 
    ? embedeData.wpFeaturedmedia.length >= 1 ? embedeData.wpFeaturedmedia[0] : null
    : null;
  
  final imageUrl = wpFeaturedMedia?.mediaDetails?.sizes?.medium?.sourceUrl;
  return imageUrl;
}