import 'package:asopedia/src/models/shared/dropdown_item.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/services/posts/posts_service.dart';

part 'list_state.dart';
  
class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListInitial());

  void setLoadingChildCategories(String title, String parentCategory) =>
    emit(ListInitialized(title: title, parentCategory: parentCategory, selectedCat: parentCategory));

  void setListLoading() =>
    emit(ListLoading(
      parentCategory: state.parentCategory, 
      title: state.title, 
      selectedCat: state.selectedCat,
      posts: state.posts
    )); 

  void setNewPosts(List<AbstractPost> posts) => 
    emit(ListLoaded(
      title: state.title, 
      parentCategory: state.parentCategory, 
      selectedCat: state.selectedCat, 
      posts: [...state.posts, ...posts]
    ));

  void changeCategory(String newCategory, List<AbstractPost> posts) =>
    emit(ListLoaded(
      title: state.title, 
      parentCategory: state.parentCategory, 
      selectedCat: newCategory, 
      posts: posts
    ));

  void setListError() => emit(ListError());
}
