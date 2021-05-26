import 'package:flutter/material.dart';

import 'package:asopedia/src/models/shared/dropdown_item.dart';

class FutureDropdown extends StatelessWidget {
  const FutureDropdown({
    @required this.future,
    @required this.onChanged
  });

  final Future future;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60.0),
      decoration: ShapeDecoration(
        color: Color(0xff061a27),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(40.0))
        )
      ),
      child: FutureBuilder<List<DropdownItem>>(
        future: this.future,
        builder: (BuildContext context, snapshot) {
          String hint = 'Cargando información';
          Function tempOnChanged = (value) {};
          List<DropdownItem> tempData = [];
          if (snapshot.hasData) {
            hint = 'Seleccione una opción';
            tempOnChanged = this.onChanged;
            tempData = snapshot.data;
          } else if (snapshot.hasError) {
            hint = 'Ha ocurrido un error';
          }
          return DropdownButton<String>(
            underline: Text(''),
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            onChanged: tempOnChanged,
            hint: Text(hint, style: TextStyle(color: Colors.white)),
            items: tempData.map((e) => DropdownMenuItem<String>(
              value: e.id,
              child: Text(e.title),
            )).toList(),
          );
        },
      ),
    );
  }
}