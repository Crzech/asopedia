import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asopedia/src/models/shared/dropdown_item.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({ @required this.categories, @required this.onChanged });

  final List<DropdownItem> categories;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCubit, ListState>(
      builder: (context, state) {
        final items = categories.map((e) => DropdownMenuItem<String>(
            value: e.id,
            child: Container(child: Text(e.title)),
          )).toList();
        items.add(DropdownMenuItem<String>(
            value: state.parentCategory,
            child: Text('Todos'),
        ));
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 60.0),
          decoration: ShapeDecoration(
              color: Color(0xff061a27),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(40.0)))),
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Color(0xff061a27)),
            child: DropdownButton<String>(
              underline: Text(''),
              value: state.selectedCat,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              onChanged: onChanged,
              style: TextStyle(color: Colors.white),
              hint: Text('Seleccione una opción', style: TextStyle(color: Colors.white)),
              items: items,
            ),
          ),
        );
      },
    );
  }
}
