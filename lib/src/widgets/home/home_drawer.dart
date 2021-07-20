import 'package:asopedia/src/util/user_preferences.dart';
import 'package:asopedia/src/widgets/login/social_media.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _url = 'https://asopedia.com/nosotros/junta-directiva/';
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xff155682)),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/logo.png'),
                maxRadius: 50,
              ),
            )
          ),
          Expanded(
            child: Column(
              children: [
                _DrawerItem(
                  title: 'Nosotros',
                  icon: Icon(FontAwesomeIcons.userMd),
                  onTap: () => Navigator.of(context).pushNamed('about'),
                ),
                _DrawerItem(
                  title: 'Junta Directiva',
                  icon: Icon(FontAwesomeIcons.users),
                  onTap: () async => await canLaunch(_url) ? await launch(_url) : print('failed launching url'),
                ),
                _DrawerItem(
                  title: 'Cerrar Sesión',
                  icon: Icon(Icons.power_settings_new),
                  onTap: ()  {
                    UserPreferences _prefs = new UserPreferences();
                    _prefs.token = '';
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                ),
              ],
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SocialMedia(),
                Text('Derechos reservados ASOPEDIA - 2021')
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({ 
    @required this.title, 
    @required this.icon, 
    @required this.onTap
  });

  final String title;
  final Widget icon;
  final Function onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: .5
          )
        )
      ),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 18)),
        leading: icon,
        onTap: onTap,
      ),
    );
  }
}
