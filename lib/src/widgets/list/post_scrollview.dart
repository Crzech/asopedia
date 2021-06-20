import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/models/shared/dropdown_item.dart';
import 'package:asopedia/src/widgets/shared/sliver_header_delegate.dart';
import 'package:asopedia/src/widgets/list/post_list_child.dart';
import 'package:asopedia/src/widgets/list/posts_appbar.dart';
import 'package:asopedia/src/widgets/shared/future_dropdown.dart';
import 'package:asopedia/src/bloc/list/list_cubit.dart';

class PostScrollView extends StatelessWidget {
  const PostScrollView(
      {Key key,
      @required ScrollController scrollController,
      @required this.screenSize,
      @required this.futureCategories,
      @required this.posts,
      this.onChangeDropdown,
      @required this.selectedCat,
      @required this.defaultCat})
      : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final Size screenSize;
  final Future<List<DropdownItem>> futureCategories;
  final List<AbstractPost> posts;
  final Function(String value) onChangeDropdown;
  final String selectedCat;
  final String defaultCat;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCubit, ListState>(
      builder: (context, state) {
        print('Default Cat: ${state.defaultCat}');
        print('Selected Cat: ${state.selectedCat}');
        print('========================');
        final _blocPosts = state.posts;
        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPersistentHeader(
              floating: true,
              delegate: SliverHeaderCustomHeaderDelegate(
                  minHeight: screenSize.height * 0.20,
                  maxHeight: screenSize.height * 0.25,
                  child: Container(
                    color: Color(0xff155682),
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PostsAppBar(),
                        SizedBox(height: 25.0),
                        FutureDropdown(
                          future: futureCategories,
                          onChanged: onChangeDropdown,
                          selectedCat: state.selectedCat,
                          defaultCat: state.defaultCat
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  )),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return PostListChild(
                    postTitle: _blocPosts[index].title.rendered,
                    postDate: _blocPosts[index].date,
                    postId: _blocPosts[index].id
                  );
                }, 
                childCount: _blocPosts.length
              )
            )
          ]
        );
      }
    );
  }
}
