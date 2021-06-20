part of 'list_cubit.dart';

@immutable
abstract class ListState {
  final bool isLoading = true;
  final List<AbstractPost> posts = [];
  final String selectedCat = null;
  final String defaultCat = null;
  final String title = null;
}

class ListInitial implements ListState {
   final bool isLoading = true;
   final posts = [];
   final String selectedCat = null;
   final String defaultCat = null;
   final String title = null;
}

class ListGlossary implements ListState {

  ListGlossary({
    @required this.selectedCat,
    @required this.isLoading,
    @required this.posts,
    @required this.defaultCat
  });
  
  final String defaultCat;
  final bool isLoading;
  final selectedCat;
  final Future<AbstractPost> Function(int) postGetter = (int postId) => PostService.getPostsById(postId);
  final List<AbstractPost> posts;
  final String title = 'Actualidad';
}
