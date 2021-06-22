import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asopedia/src/models/shared/dropdown_item.dart';
import 'package:asopedia/src/widgets/shared/sliver_header_delegate.dart';
import 'package:asopedia/src/widgets/list/post_list_child.dart';
import 'package:asopedia/src/widgets/list/posts_appbar.dart';
import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:asopedia/src/widgets/list/category_dropdown.dart';

class PostScrollView extends StatelessWidget {

  const PostScrollView({
      @required ScrollController scrollController,
      @required this.screenSize,
      @required this.categories,
      @required this.showError,
      @required this.onChangedDropdown,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final Size screenSize;
  final List<DropdownItem> categories;
  final bool showError;
  final Function onChangedDropdown;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCubit, ListState>(
      builder: (context, state) {
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
                        categories.length > 1 ? CategoryDropdown(categories: categories, onChanged: onChangedDropdown) : Container(),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  )),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return PostListChild(post: _blocPosts[index]);
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
