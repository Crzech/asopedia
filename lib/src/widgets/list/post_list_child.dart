import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  //for date format/for date locale
import 'package:intl/date_symbol_data_local.dart' as locale;



class PostListChild extends StatefulWidget {

  const PostListChild({ 
    @required this.postTitle, 
    @required this.postAuthor, 
    @required this.postDate 
  });

  final String postTitle;
  final String postAuthor;
  final DateTime postDate;

  @override
  _PostListChildState createState() => _PostListChildState();
}

class _PostListChildState extends State<PostListChild> {
  @override
  void initState() {
    super.initState();
    locale.initializeDateFormatting();
  }
  @override
  Widget build(BuildContext context) {
    final textWidth = MediaQuery.of(context).size.width * 0.6;
    final dateFormat = DateFormat.yMMMMd('es_ES');
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Color(0xFFD8D8D8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: textWidth,
                  child: Text(
                    widget.postTitle,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  widget.postAuthor,
                  style: TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 20,
                  ),
                ),
                Text(
                  dateFormat.format(widget.postDate),
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
      ),
    );
  }
}
