import 'package:asopedia/src/pages/post_page.dart';
import 'package:asopedia/src/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:asopedia/src/services/posts/posts_service.dart';
import 'package:asopedia/src/models/posts/glossary_post.dart';

class HomeSwiper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PostService.getLatestPosts(),
      builder: (BuildContext context, AsyncSnapshot<List<GlossaryPost>> snapshot) {
        if (snapshot.hasError) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(child: Text(
              'Ha ocurrido un error inesperado, por favor cierre sesión.',
              textAlign: TextAlign.center,
            ))
          );
        }

        if (snapshot.hasData) {
          return Container(
            height: 200,
            child: Swiper(
              itemCount: 10,
              itemWidth: 300,
              layout: SwiperLayout.STACK,
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                final _results = snapshot.data;
                final _postImage = getPostImage(_results[index].embedeData);
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'post', arguments: PostPageArguments(post: _results[index])),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1, 
                          child: Container(
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                              child: _postImage != null ? Image.network(_postImage, fit: BoxFit.cover) : Text(''),
                            ),
                            decoration: BoxDecoration(
                              color: ThemeManager.getAccentColor(),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                            )
                          )
                        ),
                        Container(
                          height: 50.0,
                          width: double.infinity, 
                          decoration: BoxDecoration(
                            color: ThemeManager.getPrimaryColor(),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                _results[index].title.rendered, 
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ),
                        )
                      ]
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Text('');
      },
    );
  }
}
