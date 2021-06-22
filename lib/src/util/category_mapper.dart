import 'package:flutter/material.dart';

import 'package:asopedia/src/models/categories/category.dart';
import 'package:asopedia/src/models/categories/app_category.dart';

class CategoryMapper {

  

  static AppCategory getCategoryProperties(Category cat) {
    final _categoriesMap = <String, AppCategory>{
      'actualidad': AppCategory(
        id: cat.id.toString(),
        icon: Icons.trending_up,
        title: 'Actualidad',
        subtitle: 'Tendencias'
      ),
      'buscador-de-medicamentos': AppCategory(
        id: cat.id.toString(),
        icon: Icons.search,
        title: 'Buscador',
        subtitle: 'De medicamentos'
      ),
      'eventos': AppCategory(
        id: cat.id.toString(),
        icon: Icons.calendar_today,
        title: 'Eventos',
        subtitle: 'Institucionales'
      ),
      'recursos': AppCategory(
        id: cat.id.toString(),
        icon: Icons.book,
        title: 'Recursos',
        subtitle: 'Estudios médicos'
      ),
      'revista': AppCategory(
        id: cat.id.toString(),
        icon: Icons.announcement,
        title: 'Revista',
        subtitle: 'Pediátrica'
      )
    };
    final defaultCategory = AppCategory(
      icon: Icons.article, 
      title: cat.name, 
      subtitle: cat.description, 
      id: cat.id.toString()
    );

    return (_categoriesMap ?? const {})[cat.slug] ?? defaultCategory;

  }
}