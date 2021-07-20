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
            child: Text('Categoría (Todos)'),
        ));
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 60.0),
          decoration: ShapeDecoration(
            color: Colors.white,
            shadows: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 5.0,
                offset: Offset(0.0, 1.0)
              )
            ],
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.0,
                style: BorderStyle.solid,
                color: Colors.transparent
              ),
              borderRadius: BorderRadius.all(Radius.circular(40.0))
            )
          ),
          child: DropdownButton<String>(
            underline: Text(''),
            value: state.selectedCat,
            icon: Icon(Icons.arrow_drop_down, color: Colors.grey),
            onChanged: onChanged,
            style: TextStyle(color: Color(0xff4f4f4c), fontFamily: 'MyriadPro', fontSize: 15),
            hint: Text('Seleccione una opción', style: TextStyle(color: Colors.grey)),
            items: items,
          ),
        );
      },
    );
  }
}
