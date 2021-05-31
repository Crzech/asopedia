import 'package:asopedia/src/widgets/list/posts_appbar.dart';
import 'package:asopedia/src/widgets/shared/future_dropdown.dart';
import 'package:flutter/material.dart';

import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/models/shared/dropdown_item.dart';
import 'package:asopedia/src/widgets/shared/sliver_header_delegate.dart';

class PostScrollView extends StatelessWidget {
  const PostScrollView({
    Key key,
    @required ScrollController scrollController,
    @required this.screenSize,
    @required this.futureCategories,
    @required this.posts,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final Size screenSize;
  final Future<List<DropdownItem>> futureCategories;
  final List<AbstractPost> posts;

  @override
  Widget build(BuildContext context) {
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
                        onChanged: (value) => print(value)),
                    SizedBox(height: 20.0),
                  ],
                ),
              )),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return Container(
            height: 400.0,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xff959595))),
              color: Colors.white,
            ),
          );
        }, childCount: posts.length))
      ],
    );
  }
}
