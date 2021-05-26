import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:asopedia/src/bloc/userinfo/userinfo_cubit.dart';
import 'package:asopedia/src/widgets/home/glossary_button.dart';
import 'package:asopedia/src/widgets/home/menu_button.dart';
import 'package:asopedia/src/widgets/home/home_drawer.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocBuilder<UserinfoCubit, UserinfoState>(
      builder: (context, userInfo) {
        String firstName = '';
        String lastName = '';
        String avatarUrl = '';
        if (userInfo is UserFetched) {
          firstName = userInfo.user.firstName;
          lastName = userInfo.user.lastName;
          avatarUrl = userInfo.user.avatarUrls['96'];
        }
        Widget appBarCircle = avatarUrl.length < 1 ? Text('CP') : FadeInImage.assetNetwork(
          placeholder: 'assets/images/loader.gif', 
          image: avatarUrl
        );
        return Scaffold(
          backgroundColor: Color(0xffF8F8F8),
          appBar: AppBar(
            shadowColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.grey),
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            actions: [CircleAvatar(child: ClipOval(child: appBarCircle)), SizedBox(width: 15)],
          ),
          drawer: HomeDrawer(),
          body: SingleChildScrollView(child: _Body(firstName: firstName, lastName: lastName, avatarUrl: avatarUrl, screenSize: screenSize)),
        );
      }
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    @required this.firstName,
    @required this.lastName,
    @required this.screenSize,
    @required this.avatarUrl
  });

  final String firstName;
  final String lastName;
  final Size screenSize;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      height: screenSize.height,
      margin: EdgeInsets.only(top: screenSize.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bienvenido Dr. $firstName $lastName 👋🏻',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenSize.width * 0.05)
          ),
          SizedBox(height: 20),
          GlossaryButton(screenSize: screenSize),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                crossAxisCount: 2,
                children: [
                  MenuButton(
                    title: 'Favoritos',
                    subtitle: 'Artículos Guardados',
                    icon: Icons.bookmark,
                    screenSize: screenSize,
                    onTap: () => print('Hello'),
                  ),
                  MenuButton(
                    title: 'Buscador',
                    subtitle: 'de medicamentos',
                    icon: Icons.search,
                    screenSize: screenSize,
                    onTap: () => print('Hello'),
                  ),
                  MenuButton(
                    title: 'Esquema',
                    subtitle: 'de vacunación',
                    icon: Icons.border_all,
                    screenSize: screenSize,
                    onTap: () => print('Hello'),
                  ),
                  MenuButton(
                    title: 'Referencias',
                    subtitle: 'Referencias Rápidas',
                    icon: FontAwesomeIcons.swatchbook,
                    screenSize: screenSize,
                    onTap: () => print('Hello'),
                  )
                ]),
          )
        ],
      ),
    );
  }
}