import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:asopedia/src/widgets/shared/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:asopedia/src/models/posts/content.dart';

class PostContent extends StatelessWidget {
  const PostContent({
    @required this.content,
  });

  final Content content;

  Future<void> launchLink(String url, BuildContext context) async {
    if ((await canLaunch(url))) {
      launch(url);
    } else {
      final _snackBar = SnackBar(content: Text('Error al abrir el link'));
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Html(
          customRender: {
            'a': (_, Widget child, map, el) {
              if (map['class'].runtimeType == String) {
                if (map['class'].contains('btBtn')) {
                  return RoundedButton(
                    text: el.text, 
                    color: ThemeManager.getPrimaryColor(), 
                    textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    onPressed: () async => await launchLink(map['href'], context)
                  );
                }
              }
              return GestureDetector(
                onTap: () async => await launchLink(map['href'], context),
                child: Container(
                  child: Text(
                    el.text,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            }
          },
          style: {
            '*': Style(
              fontSize: FontSize.xLarge
            ),
          },
          data: content.rendered
        ),
      ),
    );
  }
}