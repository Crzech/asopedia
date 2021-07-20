import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:flutter/material.dart';

class AnimatedGreeting extends StatefulWidget {
  const AnimatedGreeting({
    @required this.firstName,
    @required this.lastName,
  });

  final String firstName;
  final String lastName;

  @override
  _AnimatedGreetingState createState() => _AnimatedGreetingState();
}

class _AnimatedGreetingState extends State<AnimatedGreeting> with SingleTickerProviderStateMixin {

  double widgetOpacity = 1;
  bool _shouldShow = true;

  AnimationController _aController;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _aController = new AnimationController(vsync: this, duration: Duration(seconds: 4));
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 1.5)).animate(CurvedAnimation(parent: _aController, curve: Curves.elasticIn));
  }

  @override
  void dispose() {
    super.dispose();
    _aController?.dispose();
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration(milliseconds: 300), (){
      setState(() {
        widgetOpacity = 0; 
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    _aController.forward();
    return SlideTransition(
      // opacity: widgetOpacity,
      // duration: Duration(seconds: 3),
      // onEnd: () {
      //   setState(() {
      //     _shouldShow = false;        
      //   });
      // },
      position: _slideAnimation,
      child: Visibility(
        visible: _shouldShow,
        child: Container(
          width: 330,
          padding: EdgeInsets.symmetric(vertical: 10.0),
          decoration: ShapeDecoration(
            color: ThemeManager.getAccentColor(),
            shadows: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 5.0,
                offset: Offset(0.0, 1.0)
              )
            ],
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.0,
                style: BorderStyle.solid,
                color: Colors.transparent
              ),
              borderRadius: BorderRadius.all(Radius.circular(40.0))
            ),
          ),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: '''¡Hola! 👋🏻\n''', 
              style: TextStyle(
                fontFamily: 'MyriadPro',
                fontSize: 30, 
                color: Colors.white, 
                fontWeight: FontWeight.w900
              ),
              children: [
                TextSpan(
                  text: 'Dr/Dra. ${widget.firstName.split(" ")[0]} ${widget.lastName.split(" ")[0]}',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}