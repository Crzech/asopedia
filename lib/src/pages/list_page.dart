import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:asopedia/src/widgets/shared/centered_error_text.dart';
import 'package:flutter/material.dart';

import 'package:asopedia/src/widgets/list/post_scrollview.dart';
import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/models/shared/dropdown_item.dart';
import 'package:asopedia/src/widgets/list/post_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPageArguments {
  final Future<List<DropdownItem>> categoriesFuture;
  final Future<List<AbstractPost>> Function(String, int, int) postFuture;
  final String defaultCat;

  const ListPageArguments({
    @required this.categoriesFuture, 
    @required this.postFuture,
    @required this.defaultCat
  });
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
  bool _isLoading = true;
  String selectedCat;
  String defaultCat;
  bool _blocError = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _listBloc = BlocProvider.of<ListCubit>(context);
    final _pageDefaultValues = _listBloc.state;
    if (_pageDefaultValues is ListGlossary) {
      final args = ModalRoute.of(context).settings.arguments as ListPageArguments;
      futureCategories = args.categoriesFuture;
      futurePosts = args.postFuture;
      _fetchPage(_currentPage, _pageDefaultValues.selectedCat).then((newPosts) => _listBloc.changeGlossaryLoading(_pageDefaultValues.selectedCat, false, newPosts));
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _listBloc.changeGlossaryLoading(selectedCat, true, []);
          _fetchPage(_currentPage, _pageDefaultValues.selectedCat).then((newPosts) => _listBloc.changeGlossaryLoading(_pageDefaultValues.selectedCat, false, newPosts));
        }
      });
    } else {
      _blocError = true;
    }
  }

  Future<List<AbstractPost>> _fetchPage(int pageKey, String _currentCat) async {
    // setState(() => _isLoading = true);
    try {
      print('pasando pagina no: $pageKey en cat $selectedCat');
      final _newItems = await futurePosts(_currentCat, (pageKey + 1), _pageSize);
      if (_newItems.length > 0) {
        // setState(() {
        //   _currentPage++;
        //   posts.addAll(_newItems);
        // });
        // _scrollController.animateTo(_scrollController.position.pixels + 100,
        //     curve: Curves.fastLinearToSlowEaseIn,
        //     duration: Duration(milliseconds: 250));
        return _newItems;
      }
      return [];
      // setState(() => _isLoading = false);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final _listBloc = BlocProvider.of<ListCubit>(context);
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: !_blocError ? (
        Stack(
          children: [
            PostScrollView(
                scrollController: _scrollController,
                screenSize: screenSize,
                futureCategories: futureCategories,
                posts: posts,
                selectedCat: selectedCat,
                onChangeDropdown: (String value) {
                  _listBloc.changeGlossaryLoading(value, true, []);
                  _fetchPage(0, value).then((newPosts) => _listBloc.changeGlossaryLoading(value, false, newPosts));
                },
                defaultCat: defaultCat
            ),
            PostLoader(posts: posts, isLoading: _isLoading)
          ],
        )
      ) : CenteredErrorText()
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
