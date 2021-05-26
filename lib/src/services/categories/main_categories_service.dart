import 'package:asopedia/src/models/categories/main_category.dart';
import 'package:asopedia/src/models/shared/dropdown_item.dart';

const List<Map<String, dynamic>> mockCategories = [
  {"id": 1, "title": "Revista"},
  {"id": 2, "title": "Social"},
  {"id": 3, "title": 'Congresos'},
  {"id": 4, "title": "Eventos"}
];

Future<List<DropdownItem>> getMainCategories() async {
  final response = await Future.delayed(
    Duration(seconds: 2),
    () => mockCategories.map((e) => MainCategory.fromJson(e)).toList()
  );
  return response.map((e) => DropdownItem(id: e.id.toString(), title: e.title)).toList();
}
