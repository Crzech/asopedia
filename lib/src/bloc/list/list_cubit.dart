import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/services/posts/posts_service.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListInitial());

  void setGlossaryAsGetter() =>
      emit(ListGlossary(defaultCat: '2', selectedCat: '2', isLoading: true, posts: []));
  void changeGlossaryLoading(
          String selectedCat, bool isLoading, List<AbstractPost> posts) =>
      emit(ListGlossary(defaultCat: '2', selectedCat: selectedCat, isLoading: isLoading, posts: posts));
}
