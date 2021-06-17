import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:asopedia/src/widgets/shared/sliver_header_delegate.dart';

class PostHeader extends StatelessWidget {
  const PostHeader({
    @required this.screenSize, 
    @required this.title, 
    @required this.datetime,
  });
  
  final Size screenSize;
  final String title;
  final DateTime datetime;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.yMMMMd('es_ES');
    return SliverPersistentHeader(
      floating: true,
      delegate: SliverHeaderCustomHeaderDelegate(
        minHeight: screenSize.height * 0.30,
        maxHeight: screenSize.height * 0.35,
        child: Container(
          color: Color(0xff155682),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 25),
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  Expanded(child: SizedBox()),
                  Text(
                    title, 
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Text(
                    dateFormat.format(datetime),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0
                    ),
                  ),
                ]
              ),
            ),
          ),
        )
      ),
    );
  }
}