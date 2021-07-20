part of 'list_cubit.dart';

@immutable
abstract class ListState {
  final String title = '';
  final bool isLoading = true;
  final String parentCategory = '';
  final List<AbstractPost> posts = [];
  final String selectedCat = '';
  final String slug = 'generic';

}

class ListInitial implements ListState {
  final String parentCategory = '';
  final String title = '';
  final bool isLoading = true;
  final List<AbstractPost> posts = [];
  final String selectedCat = '';
  final String slug = 'generic';
}

class ListError implements ListState {
  final String parentCategory = '';
  final String title = '';
  final bool isLoading = true;
  final List<AbstractPost> posts = [];
  final String selectedCat = '';
  final String slug = 'generic';
}

class ListInitialized implements ListState {
  final String parentCategory;
  final String title;
  final bool isLoading = true;
  final List<AbstractPost> posts = [];
  final String selectedCat;
  final String slug;

  ListInitialized({
    @required this.title,
    @required this.parentCategory,
    @required this.selectedCat,
    @required this.slug
  });
}

class ListLoading implements ListState {
  final String parentCategory;
  final String title;
  final bool isLoading = true;
  final List<AbstractPost> posts;
  final String selectedCat;
  final String slug;

  ListLoading({
    @required this.title,
    @required this.parentCategory,
    @required this.selectedCat,
    @required this.posts,
    @required this.slug
  });
}
class ListLoaded implements ListState {
  final String parentCategory;
  final String title;
  final bool isLoading = false;
  final List<AbstractPost> posts;
  final String selectedCat;
  final String slug; 


  ListLoaded({
    @required this.title,
    @required this.parentCategory,
    @required this.selectedCat,
    @required this.posts,
    @required this.slug
  });
}
