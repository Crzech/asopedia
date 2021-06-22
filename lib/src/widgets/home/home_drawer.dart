import 'package:asopedia/src/util/user_preferences.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xff155682)),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
                  child: ClipOval(
                    child:
                        Image(image: AssetImage('assets/images/logo.png'))
                  ),
                ),
                maxRadius: 50,
              ),
            )
          ),
          ListTile(
            title: Text('Acerca de nosotros'),
            leading: Icon(Icons.info),
            onTap: () => Navigator.of(context).pushNamed('about'),
          ),
          ListTile(
              title: Text('Cerrar Sesión'),
              leading: Icon(Icons.logout),
              onTap: ()  {
                UserPreferences _prefs = new UserPreferences();
                _prefs.token = '';
                Navigator.pushReplacementNamed(context, 'login');
              }
          )
        ],
      ),
    );
  }
}
