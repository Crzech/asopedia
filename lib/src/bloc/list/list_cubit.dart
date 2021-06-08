import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/models/posts/glossary_post.dart';
import 'package:asopedia/src/pages/list_page.dart';
import 'package:asopedia/src/services/posts/posts_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListInitial());

  void setGlossaryAsGetter() => emit(ListGlossary());
}
