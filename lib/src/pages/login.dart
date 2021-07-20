import 'package:flutter/material.dart';

import 'package:asopedia/src/widgets/login/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.10),
              _Logo(screenHeight: screenHeight),
              SizedBox(height: screenHeight * 0.10),
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
      height: screenHeight * 0.20,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Image(image: AssetImage('assets/images/logo.png'), fit: BoxFit.cover),
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
      height: screenHeight * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(80.0)),
        color: Colors.white
      ),
    );
  }
}


