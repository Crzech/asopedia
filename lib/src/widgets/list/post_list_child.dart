import 'package:asopedia/src/models/posts/abstract_post.dart';
import 'package:asopedia/src/pages/post_page.dart';
import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:asopedia/src/widgets/shared/list_child.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  //for date format/for date locale
import 'package:intl/date_symbol_data_local.dart' as locale;



class PostListChild extends StatefulWidget {

  const PostListChild({ 
    @required this.post, 
  });

  final AbstractPost post;

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
    final textWidth = MediaQuery.of(context).size.width * 0.70;
    final dateFormat = DateFormat.yMMMMd('es_ES');
    final title = widget.post.title.rendered;
    final date = widget.post.date;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'post', arguments: PostPageArguments(post: widget.post)),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border(
            bottom: BorderSide(
              color: ThemeManager.getAccentColor(),
              width: 1.0
            )
          )
        ),
        child: ListChild(textWidth: textWidth, title: title, dateFormat: dateFormat, date: date),
      ),
    );
  }
}
