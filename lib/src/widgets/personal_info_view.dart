import 'package:flutter/material.dart';

import 'package:asopedia/src/widgets/personal_info_form.dart';

class PersonalInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff155682),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_PersonalInfoContainer(screenHeight: screenHeight)],
          ),
        ),
      ),
    );
  }
}

class _PersonalInfoContainer extends StatelessWidget {
  final screenHeight;

  const _PersonalInfoContainer({ @required this.screenHeight }); 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.85,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(80.0)),
          color: Colors.white),
      child: PersonalInfoForm(),
    );
  }
}
