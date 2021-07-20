
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asopedia/src/widgets/home/animated_greeting.dart';
import 'package:asopedia/src/widgets/home/home_swiper.dart';
import 'package:asopedia/src/widgets/home/menu_grid.dart';
import 'package:asopedia/src/bloc/userinfo/userinfo_cubit.dart';
import 'package:asopedia/src/widgets/home/home_drawer.dart';
import 'package:asopedia/src/models/categories/app_category.dart';
import 'package:asopedia/src/services/categories/main_categories_service.dart';
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
        // Widget appBarCircle = avatarUrl.length < 1 ? Text('CP') : FadeInImage.assetNetwork(
        //   placeholder: 'assets/images/loader.gif', 
        //   image: avatarUrl
        // );
        
        return Scaffold(
          backgroundColor: Color(0xffF8F8F8),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white), 
            centerTitle: true, 
            actions: [
              SizedBox(width: 20),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    width: 40.0,
                    height: 40.0,
                  )
                ),
              ), 
              SizedBox(width: 15)
            ],
            title: Text(
              '''Asociación Pediátrica \n de Guatemala''', 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            bottom: PreferredSize(
              child: Container(
                color: Colors.grey,
                height: .5,
              ),
              preferredSize: Size.fromHeight(.5),
            ),
          ),
          drawer: HomeDrawer(),
          body: Stack(
            children: [
              SingleChildScrollView(child: _Body(firstName: firstName, lastName: lastName, avatarUrl: avatarUrl, screenSize: screenSize)),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: AnimatedGreeting(firstName: firstName, lastName: lastName),
                ),
              ),
            ],
          ),
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
      // padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: screenSize.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text(
          //   'Bienvenido Dr. $firstName $lastName 👋🏻',
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenSize.width * 0.05)
          // ),
          // SizedBox(height: 20),
          FutureBuilder(
            future: getParentCategories(),
            builder: (BuildContext context, AsyncSnapshot<List<AppCategory>> snapshot) {
              if (snapshot.hasData) {
                return MenuGrid(screenSize: screenSize, categories: snapshot.data);
              }
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(snapshot.error.toString(), textAlign: TextAlign.center),
                  )
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          SizedBox(height: 30),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //   child: Text(
          //     'Lo más nuevo:', 
          //     style: TextStyle( color: ThemeManager.getAccentColor(), fontSize: 20, fontWeight: FontWeight.bold )
          //   ),
          // ),
          HomeSwiper(),
          SizedBox(height: 20),
          // Flexible(child: SizedBox(height: 1000), fit: FlexFit.loose)
        ],
      ),
    );
  }
}


