import 'package:asopedia/src/services/about/about_service.dart';
import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:flutter/material.dart';


class StoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
      ),
      backgroundColor: Color(0xff155682),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child:
                          Image(image: AssetImage('assets/images/logo.png'))
                    ),
                    maxRadius: 100,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow> [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.0)
                  )
                ],
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Historia', 
                    style: TextStyle(
                      color: ThemeManager.getPrimaryColor(), 
                      fontWeight: FontWeight.bold, 
                      fontSize: 40.0,
                    )
                  ),
                  SizedBox(height: 4),
                  Container(height: 3.0, width: screenSize.width * 0.17, color: ThemeManager.getPrimaryColor()),
                  SizedBox(height: 20),
                  Text(AboutService.getStoryText(), textAlign: TextAlign.justify, style: TextStyle(fontSize: 16.0))
                ],
              )
            )

          ],
        ),
      ),
   );
  }
}