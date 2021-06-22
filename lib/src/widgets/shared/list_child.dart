import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  //for date format/for date locale

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
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                dateFormat.format(date),
                style: TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 24,
          )
        )
      ],
    );
  }
}