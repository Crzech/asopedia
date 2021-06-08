part of 'list_cubit.dart';

@immutable
abstract class ListState {}

class ListInitial extends ListState {}

class ListGlossary extends ListState {
  final Future<AbstractPost> Function(int) postGetter = (int postId) => PostService.getPostsById(postId);
}
