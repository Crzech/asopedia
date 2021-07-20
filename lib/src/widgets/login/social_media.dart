import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';



class SocialMedia extends StatelessWidget {

  Future<void> launchLink(String link, BuildContext context) async {
    if ((await canLaunch(link))) {
      launch(link);
    } else {
      final _snackBar = SnackBar(content: Text('Error al abrir el link'));
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(FontAwesomeIcons.facebook, color: Colors.grey, size: 25), 
          onPressed: () => launchLink('https://www.facebook.com/ASOPEDIAGUATE', context)
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.youtube, color: Colors.grey, size: 25), 
          onPressed: () async => await launchLink('https://www.youtube.com/channel/UCkeaRL5rPMT-HYU-iOFG03A/videos', context)
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.instagram, color: Colors.grey, size: 25), 
          onPressed: () async => await launchLink('https://www.instagram.com/asopediagt/', context)
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.globe, color: Colors.grey, size: 25), 
          onPressed: () async => await launchLink('https://asopedia.com/', context)
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.graduationCap, color: Colors.grey, size: 25), 
          onPressed: () async => await launchLink('https://emc.asopedia.com/login/index.php', context)
        ),
      ],
    );
  }
}