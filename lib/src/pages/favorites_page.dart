import 'package:asopedia/src/bloc/favorites/favorites_cubit.dart';
import 'package:asopedia/src/models/posts/only_id_post.dart';
import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; //for date format/for date locale
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            padding: EdgeInsets.all(0),
            onPressed: () => Navigator.pop(context)),
        centerTitle: true,
        title: Text('Mis favoritos',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          return FutureBuilder(
            future: PostService.getFavorites(),
            builder: (BuildContext context,
                AsyncSnapshot<List<FavoritesResult>> snapshot) {
              if (snapshot.hasData) {
                final favoritesList = snapshot.data;
                final textWidth = MediaQuery.of(context).size.width * 0.6;
                final dateFormat = DateFormat.yMMMMd('es_ES');
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'post',
                          arguments: PostPageArguments(
                            post: OnlyIdPost(id: favoritesList[index].id),
                            comesFromFavorites: true,
                          )),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          border: Border(
                            bottom: BorderSide(
                                color: ThemeManager.getPrimaryColor(),
                                width: 1.0),
                          ),
                        ),
                        child: ListChild(
                            textWidth: textWidth,
                            title: favoritesList[index].title.rendered,
                            dateFormat: dateFormat,
                            date: favoritesList[index].created),
                      ),
                    );
                  },
                  itemCount: favoritesList.length,
                );
              }
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Text(
                      'Ha ocurrido un error inesperado, por favor inténtelo de nuevo.',
                      textAlign: TextAlign.center,
                    )
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}
