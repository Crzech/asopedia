import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:flutter/material.dart';

import 'package:asopedia/src/models/categories/app_category.dart';
import 'package:asopedia/src/widgets/home/menu_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({
    @required this.screenSize,
    @required this.categories,
  });

  final Size screenSize;
  final List<AppCategory> categories;

  @override
  Widget build(BuildContext context) {
    final _listBloc = BlocProvider.of<ListCubit>(context);
    return Flexible(
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          MenuButton(
            title: 'Favoritos',
            subtitle: 'Artículos Guardados',
            icon: Icons.bookmark,
            screenSize: screenSize,
            onTap: () => Navigator.pushNamed(context, 'favorites'),
          ),
          ...categories.map((e) => MenuButton(
            screenSize: screenSize, 
            title: e.title, 
            subtitle: e.subtitle, 
            icon: e.icon, 
            onTap: () {
              _listBloc.setLoadingChildCategories(e.title, e.id);
              Navigator.pushNamed(context, 'list2');
            }
          )).toList(),
          MenuButton(
            title: 'Esquema',
            subtitle: 'de vacunación',
            icon: Icons.border_all,
            screenSize: screenSize,
            onTap: () => Navigator.of(context).pushNamed('vaccine_schedule'),
          ),
        ]
      ),
    );
  }
}