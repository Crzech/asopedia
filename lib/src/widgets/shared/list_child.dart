import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; //for date format/for date locale

class ListChild extends StatelessWidget {
  const ListChild({
    Key key,
    @required this.textWidth,
    @required this.title,
    @required this.dateFormat,
    @required this.date,
  }) : super(key: key);

  final double textWidth;
  final String title;
  final DateFormat dateFormat;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: textWidth,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ThemeManager.getPrimaryColor()),
                ),
              ),
              BlocBuilder<ListCubit, ListState>(
                builder: (context, state) {
                  return Visibility(
                    visible: state.slug != 'eventos',
                    child: Text(
                      dateFormat.format(date),
                      style: TextStyle(
                        color: Color(0xFF9E9E9E),
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: ThemeManager.getPrimaryColor(),
              size: 24,
            ))
      ],
    );
  }
}
