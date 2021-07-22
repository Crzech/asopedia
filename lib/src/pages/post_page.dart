import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart' as locale;
import 'package:intl/intl.dart';

import 'package:asopedia/src/bloc/favorites/favorites_cubit.dart';
import 'package:asopedia/src/models/posts/glossary_post.dart';
import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/services/posts/posts_service.dart';
import 'package:asopedia/src/widgets/post/post_content.dart';
import 'package:asopedia/src/widgets/post/post_header.dart';

class PostPageArguments {
  const PostPageArguments(
      {@required this.post, this.comesFromFavorites = false});

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

  Map<String, dynamic> getFloatingIconButton(addedToFavorites,
      comesFromFavorites, AbstractPost post, FavoritesCubit favCubit) {
    final defaultMethod = () {
      PostService.addToFavorites(post).then((bool added) {
        final _snackBar =
            SnackBar(content: Text('Favoritos actualizados correctamente'));
        this.setState(() {
          _addedToFavorites = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      }).catchError((error) {
        final _snackBar = SnackBar(content: Text(error.toString()));
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      });
    };
    if (comesFromFavorites) {
      return {
        'icon': Icons.bookmark,
        'color': Color(0xffff5252),
        'method': () => {
              PostService.removeFromFavorites(post).then((bool added) {
                favCubit.refreshFavorites();
                final _snackBar = SnackBar(
                    content: Text('Favoritos actualizados correctamente'));
                ScaffoldMessenger.of(context).showSnackBar(_snackBar);
              }).catchError((error) {
                final _snackBar = SnackBar(content: Text(error.toString()));
                ScaffoldMessenger.of(context).showSnackBar(_snackBar);
              })
            },
        'tooltip': 'Eliminar de favoritos'
      };
    } else if (_addedToFavorites) {
      return {
        'icon': Icons.bookmark,
        'method': defaultMethod,
        'color': ThemeManager.getAccentColor(),
        'tooltip': 'Agregar a favoritos'
      };
    }
    return {
      'icon': Icons.bookmark_border,
      'method': defaultMethod,
      'tooltip': 'Agregar a favoritos',
      'color': ThemeManager.getAccentColor()
    };
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as PostPageArguments;
    final screenSize = MediaQuery.of(context).size;
    final _favCubit = BlocProvider.of<FavoritesCubit>(context);
    final _buttonData = getFloatingIconButton(
        _addedToFavorites, args.comesFromFavorites, args.post, _favCubit);
    final _dateFormat = DateFormat.yMMMMd('es_ES');
    return Scaffold(
      body: FutureBuilder<GlossaryPost>(
        future: PostService.getPostsById(args.post.id),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data.content.rendered);
            return CustomScrollView(
              slivers: [
                PostHeader(
                    screenSize: screenSize,
                    title: snapshot.data.title.rendered,
                    datetime: snapshot.data.date,
                    embedeData: snapshot.data.embedeData),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 28),
                    child: Text(
                      snapshot.data.title.rendered,
                      style: TextStyle(
                        height: 1,
                        color: ThemeManager.getPrimaryColor(),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                BlocBuilder<ListCubit, ListState>(
                  builder: (context, state) {
                    return state.slug != 'eventos' ? SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 10.0),
                        child: Text(
                          _dateFormat.format(snapshot.data.date),
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ) : SliverToBoxAdapter(child: SizedBox(height: 0));
                  },
                ),
                PostContent(content: snapshot.data.content)
              ],
            );
          }

          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                  child: Text(
                'Ha ocurrido un error inesperado, por favor cierre sesión y inténte de nuevo',
                textAlign: TextAlign.center,
              )),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_buttonData['icon']),
        backgroundColor: _buttonData['color'],
        onPressed: _buttonData['method'],
        tooltip: _buttonData['tooltip'],
      ),
    );
  }
}
