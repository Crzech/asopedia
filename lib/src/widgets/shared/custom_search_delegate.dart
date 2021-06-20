import 'package:asopedia/src/models/search/search_result.dart';
import 'package:asopedia/src/pages/post_page.dart';
import 'package:asopedia/src/services/search/search_service.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate{

  CustomSearchDelegate({ this.categoryId }) : super();
  final String categoryId; 

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
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation
      ), 
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
      future: SearchService.getSearchResults(query),
      builder: (BuildContext context, AsyncSnapshot<List<SearchResult>> snapshot) {
        if ( snapshot.hasData ) {
          final _results = snapshot.data;

          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.article),
                title: Text(_results[index].title),
                onTap: () {
                  close(context, null);
                  Navigator.of(context).pushNamed('post', arguments: PostPageArguments(postId: _results[index].id));
                },
              );
            },
            itemCount: snapshot.data.length,
          );
        }

        if (snapshot.hasError) {
          return Container(
            padding: EdgeInsets.symmetric( horizontal: 15.0), 
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