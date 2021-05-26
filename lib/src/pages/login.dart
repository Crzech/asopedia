import 'package:flutter/material.dart';

import 'package:asopedia/src/widgets/login/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _Logo(screenHeight: screenHeight),
              SizedBox(height: screenHeight * 0.05),
              _LoginContainer(screenHeight: screenHeight)
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xff155682),
    );
  }
}
class _Logo extends StatelessWidget {
  const _Logo({
    @required this.screenHeight,
  });
  final double screenHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.25,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Image(image: AssetImage('assets/images/logo.png'), fit: BoxFit.scaleDown),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle
      ),
    );
  }
}

class _LoginContainer extends StatelessWidget {
  const _LoginContainer({
    @required this.screenHeight,
  });

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoginForm(),
      width: double.infinity,
      height: screenHeight * 0.60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(80.0)),
        color: Colors.white
      ),
    );
  }
}


