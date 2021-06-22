part of 'list_cubit.dart';

@immutable
abstract class ListState {
  final String title = '';
  final bool isLoading = true;
  final String parentCategory = '';
  final List<AbstractPost> posts = [];
  final String selectedCat = '';

}

class ListInitial implements ListState {
  final String parentCategory = '';
  final String title = '';
  final bool isLoading = true;
  final List<AbstractPost> posts = [];
  final String selectedCat = '';
}

class ListError implements ListState {
  final String parentCategory = '';
  final String title = '';
  final bool isLoading = true;
  final List<AbstractPost> posts = [];
  final String selectedCat = '';
}

class ListInitialized implements ListState {
  final String parentCategory;
  final String title;
  final bool isLoading = true;
  final List<AbstractPost> posts = [];
  final String selectedCat;

  ListInitialized({
    @required this.title,
    @required this.parentCategory,
    @required this.selectedCat
  });
}

class ListLoading implements ListState {
  final String parentCategory;
  final String title;
  final bool isLoading = true;
  final List<AbstractPost> posts;
  final String selectedCat;

  ListLoading({
    @required this.title,
    @required this.parentCategory,
    @required this.selectedCat,
    @required this.posts,
  });
}
class ListLoaded implements ListState {
  final String parentCategory;
  final String title;
  final bool isLoading = false;
  final List<AbstractPost> posts;
  final String selectedCat;

  ListLoaded({
    @required this.title,
    @required this.parentCategory,
    @required this.selectedCat,
    @required this.posts,
  });
}
