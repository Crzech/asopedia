import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:flutter/material.dart';

import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as PostPageArguments;
    return Scaffold(
      body: BlocBuilder<ListCubit, ListState>(
        builder: (BuildContext context, state) {
          if (state is ListGlossary) {
            return FutureBuilder<AbstractPost>(
              future: state.postGetter(args.postId),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return Center(child: Text('Hello from post'));
                }
                return Center(child: CircularProgressIndicator());
              },
            ); 
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}