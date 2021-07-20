import 'package:flutter/material.dart';

import 'package:asopedia/src/models/categories/category.dart';
import 'package:asopedia/src/models/categories/app_category.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryMapper {

  

  static AppCategory getCategoryProperties(Category cat) {
    final _categoriesMap = <String, AppCategory>{
      'actualidad': AppCategory(
        id: cat.id.toString(),
        icon: FontAwesomeIcons.sync,
        title: 'Actualidad',
        subtitle: '',
        slug: cat.slug
      ),
      'buscador-de-medicamentos': AppCategory(
        id: cat.id.toString(),
        icon: FontAwesomeIcons.notesMedical,
        title: 'Medicamentos',
        subtitle: 'De medicamentos',
        openBrowser: 'http://e-lactancia.org',
        slug: cat.slug
      ),
      'eventos': AppCategory(
        id: cat.id.toString(),
        icon: FontAwesomeIcons.calendarAlt,
        title: 'Eventos institucionales',
        subtitle: '',
        slug: cat.slug
      ),
      'recursos': AppCategory(
        id: cat.id.toString(),
        icon: FontAwesomeIcons.fileMedical,
        title: 'Recursos - Estudios médicos',
        subtitle: '',
        slug: cat.slug
      ),
      'revista': AppCategory(
        id: cat.id.toString(),
        icon: FontAwesomeIcons.book,
        title: 'Guatemala Pediátrica',
        subtitle: '',
        slug: cat.slug
      )
    };
    final defaultCategory = AppCategory(
      icon: Icons.article, 
      title: cat.name, 
      subtitle: cat.description, 
      id: cat.id.toString(),
      slug: cat.slug
    );

    return (_categoriesMap ?? const {})[cat.slug] ?? defaultCategory;

  }
}