import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:asopedia/src/models/posts/abstract_post.dart';

class PostLoader extends StatelessWidget {
  const PostLoader({
    @required this.posts,
    @required this.isLoading,
  });

  final List<AbstractPost> posts;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<ListCubit, ListState>(
          builder: (context, state) {
            // print(state.isLoading);
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: posts.length > 1
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.center,
              children: [
                state.isLoading ? CircularProgressIndicator() : Container(),
                SizedBox(height: 20)
              ],
            );
          },
        ),
      ],
    );
  }
}
