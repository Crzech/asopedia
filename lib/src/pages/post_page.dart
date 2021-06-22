import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart' as locale;

import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/services/posts/posts_service.dart';
import 'package:asopedia/src/widgets/post/post_content.dart';
import 'package:asopedia/src/widgets/post/post_header.dart';

class PostPageArguments {

  const PostPageArguments({ 
    @required this.post, 
    this.comesFromFavorites = false 
  });
  
  final AbstractPost post;
  final bool comesFromFavorites;
}

class PostPage extends StatefulWidget {

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  
  @override
  void initState() { 
    super.initState();
    locale.initializeDateFormatting();
  }

  bool _addedToFavorites = false;

  Map<String, dynamic> getFloatingIconButton(addedToFavorites, comesFromFavorites) {
    if (comesFromFavorites) {
      return {
        'icon': Icons.bookmark,
        'color': Color(0xffff5252)
      };
    } else if (_addedToFavorites) {
      return {
        'icon': Icons.bookmark,
        'color': ThemeManager.getAccentColor()
      };
    }
    return {
      'icon': Icons.bookmark_border,
      'color': ThemeManager.getAccentColor()
    };
  }



  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as PostPageArguments;
    final screenSize = MediaQuery.of(context).size;
    final _buttonData = getFloatingIconButton(_addedToFavorites, args.comesFromFavorites);
    return Scaffold(
      body: FutureBuilder<AbstractPost>(
        future: PostService.getPostsById(args.post.id),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data.content.rendered);
            return CustomScrollView(
              slivers: [
                PostHeader(
                  screenSize: screenSize,  
                  title: snapshot.data.title.rendered,
                  datetime: snapshot.data.date
                ),
                PostContent(content: snapshot.data.content)
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_buttonData['icon']),
        backgroundColor: _buttonData['color'],
        onPressed: () {
          PostService
            .addToFavorites(args.post)
            .then((bool added) {
              final _snackBar = SnackBar(content: Text('Favoritos actualizados correctamente'));
              this.setState(() {
                _addedToFavorites = true;              
              });
              ScaffoldMessenger.of(context).showSnackBar(_snackBar);
            })
            .catchError((error) {
              final _snackBar = SnackBar(content: Text(error.toString()));
              ScaffoldMessenger.of(context).showSnackBar(_snackBar);
            });
        },
      ),
    );
  }
}