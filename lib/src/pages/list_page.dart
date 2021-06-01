import 'package:asopedia/src/widgets/list/post_loader.dart';
import 'package:flutter/material.dart';

import 'package:asopedia/src/widgets/list/post_scrollview.dart';
import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/models/shared/dropdown_item.dart';


class ListPageArguments {
  final Future<List<DropdownItem>> categoriesFuture;
  final Future<List<AbstractPost>> Function(String, int, int) postFuture;

  const ListPageArguments(
      {@required this.categoriesFuture, @required this.postFuture});
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  static const _pageSize = 10;
  Future<List<DropdownItem>> futureCategories;
  Future<List<AbstractPost>> Function(String, int, int) futurePosts;
  int _currentPage = 0;
  ScrollController _scrollController = new ScrollController();
  List<AbstractPost> posts = [];
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context).settings.arguments as ListPageArguments;
    futureCategories = args.categoriesFuture;
    futurePosts = args.postFuture;
    _fetchPage(_currentPage);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchPage(_currentPage);
      }
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    setState(() => _isLoading = true);
    try {
      print('pasando pagina no: $pageKey');
      final _newItems = await futurePosts('32', (pageKey + 1), _pageSize);
      if (_newItems.length > 0) {
        setState(() {
          _currentPage++;
          posts.addAll(_newItems);
        });
        _scrollController.animateTo(
          _scrollController.position.pixels + 100, 
          curve: Curves.fastLinearToSlowEaseIn, duration: Duration( milliseconds: 250 )
        );
      }
      setState(() => _isLoading = false);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: Stack(
        children: [
          PostScrollView(scrollController: _scrollController, screenSize: screenSize, futureCategories: futureCategories, posts: posts),
          PostLoader(posts: posts, isLoading: _isLoading)
        ],
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}