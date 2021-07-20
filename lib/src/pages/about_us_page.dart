import 'package:asopedia/src/services/about/about_service.dart';
import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:flutter/material.dart';


class AboutUsPage extends StatelessWidget {

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
                    backgroundImage: AssetImage('assets/images/logo.png'),
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

                  _Paragraph(screenSize: screenSize, title: 'Historia', body: AboutService.getStoryText()),
                  _Paragraph(screenSize: screenSize, title: 'Misión', body: AboutService.getMision()),
                  _Paragraph(screenSize: screenSize, title: 'Visión', body: AboutService.getVision()),
                  _Paragraph(screenSize: screenSize, title: 'Valores', body: AboutService.getValores())
                ],
              )
            )

          ],
        ),
      ),
   );
  }
}

class _Paragraph extends StatelessWidget {
  const _Paragraph({
    @required this.screenSize, 
    @required this.title, 
    @required this.body,
  });

  final Size screenSize;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, 
          style: TextStyle(
            color: ThemeManager.getPrimaryColor(), 
            fontWeight: FontWeight.bold, 
            fontSize: 40.0,
          )
        ),
        SizedBox(height: 4),
        Container(height: 3.0, width: screenSize.width * 0.17, color: ThemeManager.getPrimaryColor()),
        SizedBox(height: 20),
        Text(body, style: TextStyle(fontSize: 16.0), textAlign: TextAlign.justify),
      ],
    );
  }
}