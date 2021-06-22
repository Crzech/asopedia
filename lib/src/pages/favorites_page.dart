import 'package:asopedia/src/models/posts/only_id_post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  //for date format/for date locale
import 'package:intl/date_symbol_data_local.dart' as locale;


import 'package:asopedia/src/pages/post_page.dart';
import 'package:asopedia/src/services/posts/posts_service.dart';
import 'package:asopedia/src/models/posts/favorites_result.dart';
import 'package:asopedia/src/widgets/shared/list_child.dart';

class FavoritesPage extends StatefulWidget {

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    locale.initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(),
      body: FutureBuilder(
        future: PostService.getFavorites(),
        builder: (BuildContext context, AsyncSnapshot<List<FavoritesResult>> snapshot) {
          if (snapshot.hasData) {
            final favoritesList = snapshot.data;
            final textWidth = MediaQuery.of(context).size.width * 0.6;
            final dateFormat = DateFormat.yMMMMd('es_ES');
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'post', arguments: PostPageArguments(
                    post: OnlyIdPost(id: favoritesList[index].id),
                    comesFromFavorites: true,
                  )),
                  child: Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Color(0xFFD8D8D8),
                      ),
                    ),
                    child: ListChild(
                      textWidth: textWidth, 
                      title: favoritesList[index].title.rendered, 
                      dateFormat: dateFormat, 
                      date: favoritesList[index].created
                    ),
                  ),
                );
              },
              itemCount: favoritesList.length,
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
   );
  }
}