import 'package:flutter/material.dart';

import 'package:asopedia/src/models/posts/glossary_post.dart';
import 'package:asopedia/src/pages/post_page.dart';
import 'package:asopedia/src/services/search/search_service.dart';
import 'package:asopedia/src/themes/theme_manager.dart';

class CustomSearchDelegate extends SearchDelegate{

  CustomSearchDelegate({ @required this.categoryId }) : super();
  final String categoryId; 

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    assert(theme != null);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        titleSpacing: 40,
        brightness: colorScheme.brightness,
        backgroundColor: ThemeManager.getPrimaryColor(),
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
        textTheme: theme.textTheme,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white), 
      ),
      textTheme: theme.textTheme.copyWith(
        headline6: TextStyle(color: Colors.white, fontSize: 20)
      )
    );
  }

  // PreferredSizeWidget buildBottom(BuildContext context) => PreferredSize(
  //   child: Container(
  //     height: 20,
  //     color: ThemeManager.getPrimaryColor(),
  //   ), 
  //   preferredSize: Size(double.infinity, 20),
  // );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = '';
      })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios), 
      onPressed: () => close(context, null)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();
    return FutureBuilder(
      future: SearchService.getSearchResults(query, categoryId),
      builder: (BuildContext context, AsyncSnapshot<List<GlossaryPost>> snapshot) {
        if ( snapshot.hasData ) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final _results = snapshot.data;
              final embedeData = _results[index].embedeData;
              final wpFeaturedMedia = embedeData != null 
                ? embedeData.wpFeaturedmedia.length >= 1 ? embedeData.wpFeaturedmedia[0] : null
                : null;
              final imageUrl = wpFeaturedMedia?.mediaDetails?.sizes?.medium?.sourceUrl;
              return Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: ThemeManager.getAccentColor(), width: 1.0))
                ),
                child: Center(
                  child: ListTile(
                    leading: imageUrl != null ? Image.network(
                      imageUrl, 
                      fit: BoxFit.cover
                    ) : Text(''),
                    title: Text(
                      _results[index].title.rendered, 
                      style: TextStyle(
                        color: ThemeManager.getPrimaryColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: ThemeManager.getPrimaryColor()),
                    onTap: () {
                      close(context, null);
                      Navigator.of(context).pushNamed('post', arguments: PostPageArguments(post: _results[index]));
                    },
                  ),
                ),
              );
            },
            itemCount: snapshot.data.length,
          );
        }

        if (snapshot.hasError) {
          return Container(
            padding: EdgeInsets.symmetric( horizontal: 20.0), 
            child: Center(
              child: Text(snapshot.error.toString(), textAlign: TextAlign.center)
            )
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  String get searchFieldLabel => 'Buscar';
}