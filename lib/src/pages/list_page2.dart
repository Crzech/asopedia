import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:asopedia/src/services/categories/main_categories_service.dart';
import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/models/shared/dropdown_item.dart';
import 'package:asopedia/src/services/posts/posts_service.dart';
import 'package:asopedia/src/widgets/list/post_loader.dart';
import 'package:asopedia/src/widgets/list/post_scrollview.dart';

class ListPage2 extends StatefulWidget {
  @override
  _ListPage2State createState() => _ListPage2State();
}

class _ListPage2State extends State<ListPage2> {
  final ScrollController _scrollController = new ScrollController();
  static const _pageSize = 10;
  int _currentPage = 1;

  @override
   void didChangeDependencies() {
    super.didChangeDependencies();
    ListCubit _listBloc = BlocProvider.of<ListCubit>(context);
    final _pageDefaultValues = _listBloc.state;
    if (_pageDefaultValues.posts.length < 1) {
      _listBloc.setListLoading();
      _fetchPage(_currentPage, _pageDefaultValues.selectedCat)
        .then((newPosts) => _listBloc.setNewPosts(newPosts))
        .catchError((err) => _listBloc.setListError());
    } 
    _scrollController.addListener(() {
      ListCubit _listBloc = BlocProvider.of<ListCubit>(context);
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _listBloc.setListLoading();
        _fetchPage(_currentPage + 1, _listBloc.state.selectedCat)
          .then((newPosts) {
            if (newPosts.length >= 1) {
              this.setState(() {
                _currentPage++;          
              });
            }
            _listBloc.setNewPosts(newPosts);
          })
          .catchError((err) {
            _listBloc.setListError();
          });
      }
    });
  }

  Future<List<AbstractPost>> _fetchPage(int pageKey, String _selectedCat) async {
    print('pasando pagina no: $pageKey en cat $_selectedCat');
    final _newItems = await PostService.getPostsByCategoryId(_selectedCat, pageKey, _pageSize).catchError((err) => throw err);
    return _newItems;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final _listBloc = BlocProvider.of<ListCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ListCubit, ListState>(
        builder: (context, state) {
          if (state is ListError) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Center(child: Text('Lo sentimos, ha sucedido un error inesperado, cierre la aplicación e intente de nuevo', textAlign: TextAlign.center)),
            );
          }
          return FutureBuilder(
            future: getChildCategories(state.parentCategory),
            builder: (BuildContext context, AsyncSnapshot<List<DropdownItem>> snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    PostScrollView(
                      scrollController: _scrollController, 
                      screenSize: screenSize, 
                      categories: snapshot.data, 
                      showError: false,
                      onChangedDropdown: (value) {
                        _listBloc.setListLoading();
                        _fetchPage(1, value)
                          .then((newPosts) {
                            this.setState(() {
                              _currentPage = 1;                            
                            });
                            _listBloc.changeCategory(value, newPosts);
                          })
                          .catchError((err) => _listBloc.setListError());
                      },
                    ),
                    PostLoader(posts: state.posts, isLoading: state.isLoading)
                  ],
                );
              }

              if(snapshot.hasError) {
                return Center(
                  child: Padding(
                    child: Text(
                      'Ha ocurrido un error desconocido, por favor inténtelo de nuevo',
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }

  @override
    void dispose() {
      super.dispose();
      _scrollController?.dispose();
    }
}
