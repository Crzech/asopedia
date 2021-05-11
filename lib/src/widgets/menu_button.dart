import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    @required this.screenSize,
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    @required this.onTap
  });

  final Size screenSize;
  final String title;
  final String subtitle;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        height: screenSize.height * 0.30,
        child: Stack(
          children: [
            Positioned(
              left: 15.0,
              top: 15.0,
              child: FaIcon(icon, color: Colors.white70),
            ),
            Positioned(
              bottom: 15.0,
              right: 15.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(title,
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text(subtitle,
                      style: TextStyle(fontSize: 12, color: Colors.grey))
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: Color(0xff155682),
            borderRadius: BorderRadius.all(Radius.circular(25))),
      ),
    );
  }
}