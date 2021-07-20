import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:asopedia/src/models/posts/abstract_post.dart';

part 'list_state.dart';
  
class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListInitial());

  void setLoadingChildCategories(String title, String parentCategory, String slug) =>
    emit(ListInitialized(title: title, parentCategory: parentCategory, selectedCat: parentCategory, slug: slug));

  void setListLoading() =>
    emit(ListLoading(
      parentCategory: state.parentCategory, 
      title: state.title, 
      selectedCat: state.selectedCat,
      posts: state.posts,
      slug: state.slug,
    )); 

  void setNewPosts(List<AbstractPost> posts) => 
    emit(ListLoaded(
      title: state.title, 
      parentCategory: state.parentCategory, 
      selectedCat: state.selectedCat, 
      posts: [...state.posts, ...posts],
      slug: state.slug,
    ));

  void changeCategory(String newCategory, List<AbstractPost> posts) =>
    emit(ListLoaded(
      title: state.title, 
      parentCategory: state.parentCategory, 
      selectedCat: newCategory, 
      posts: posts,
      slug: state.slug,
    ));

  void setListError() => emit(ListError());
}
