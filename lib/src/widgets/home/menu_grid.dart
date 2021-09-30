import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';


import 'package:asopedia/src/models/categories/app_category.dart';
import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({
    @required this.screenSize,
    @required this.categories,
  });

  final Size screenSize;
  final List<AppCategory> categories;

  @override
  Widget build(BuildContext context) {
    final _listBloc = BlocProvider.of<ListCubit>(context);
    final _listObjects = [
      {
        'title': 'Mis favoritos',
        'icon': Icon(Icons.star, size: 35, color: ThemeManager.getPrimaryColor()),
        'onTap': () => Navigator.pushNamed(context, 'favorites')
      },
      ...categories.map((e) => {
        'title': e.title,
        'icon': Icon(e.icon, size: 35, color: ThemeManager.getPrimaryColor()),
        'onTap': () async {
          if (e.openBrowser != null && e.openBrowser.length > 0){
            if ((await canLaunch(e.openBrowser))) {
              if (Platform.isIOS) {
                try {
                  switch (await AppTrackingTransparency.trackingAuthorizationStatus) {
                    case TrackingStatus.authorized:
                      launch(e.openBrowser);
                      break;
                    case TrackingStatus.notDetermined:
                      await AppTrackingTransparency.requestTrackingAuthorization();
                      break;
                    default:
                      final _snackBar = SnackBar(content: Text('Lo sentimos, su dispositivo no admite cookies de proveedores externos, para arreglar esto, vaya a Configuración > ASOPEDIA > Permitir rastreo.'));
                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                  }
                } on PlatformException {
                  final _snackBar = SnackBar(content: Text('Lo sentimos, ha ocurrido un error inesperado.'));
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                }
              } else {
                launch(e.openBrowser);
              }
            } else {
              final _snackBar = SnackBar(content: Text('Lo sentimos, ha ocurrido un error inesperado, inténtelo de nuevo'));
              ScaffoldMessenger.of(context).showSnackBar(_snackBar);
            }
            return;
          }
          _listBloc.setLoadingChildCategories(e.title, e.id, e.slug);
          Navigator.pushNamed(context, 'list2');
        }
      }).toList(),
      // {
      //   'title': 'Esquema de vacunación',
      //   'icon': Icon(FontAwesomeIcons.syringe, size: 35, color: ThemeManager.getPrimaryColor()),
      //   'onTap': () => Navigator.pushNamed(context, 'vaccine_schedule')
      // }
    ];

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _listObjects.length,
      itemBuilder: (context, int index) {
        return Container(
          height: 70,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: .5, color: Colors.grey)
            )
          ),
          child: Center(
            child: ListTile(
              leading: _listObjects[index]['icon'],
              title: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(_listObjects[index]['title'], style: TextStyle(color: Color(0xff4f4f4c), fontSize: 18.0)),
              ),
              onTap: _listObjects[index]['onTap'],
            ),
          ),
        );
      }
    );
  }
}