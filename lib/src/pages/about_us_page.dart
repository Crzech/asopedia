import 'package:asopedia/src/widgets/sample_text.dart';
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
        child: Container(
          height: screenSize.height,
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
              Expanded(
                child: Container(
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
                  child: Text(sampleText, textAlign: TextAlign.justify)
                ),
              )

            ],
          ),
        ),
      ),
   );
  }
}