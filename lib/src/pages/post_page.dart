import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart' as locale;

import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:asopedia/src/widgets/post/post_content.dart';
import 'package:asopedia/src/widgets/post/post_header.dart';

class PostPageArguments {

  const PostPageArguments({ @required this.postId });
  
  final int postId;
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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as PostPageArguments;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<ListCubit, ListState>(
        builder: (BuildContext context, state) {
          if (state is ListGlossary) {
            return FutureBuilder<AbstractPost>(
              future: state.postGetter(args.postId),
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
            ); 
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.bookmark_border),
        onPressed: () => print('Add to favorites'),
      ),
    );
  }
}