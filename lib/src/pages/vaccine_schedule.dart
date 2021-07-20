import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import 'package:asopedia/src/services/vaccine_schedule/vaccine_schedule_service.dart';
import 'package:asopedia/src/themes/theme_manager.dart';



class VaccineSchedulePage extends StatelessWidget {
  final vaccines = VaccineScheduleService.getVaccinationData();
  @override
  Widget build(BuildContext context) {
    return DefaultStickyHeaderController(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: ThemeManager.getPrimaryColor(),
          backgroundColor: ThemeManager.getPrimaryColor(),
          foregroundColor: ThemeManager.getPrimaryColor(),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), padding: EdgeInsets.all(0), onPressed: () => Navigator.pop(context)),
          centerTitle: true,
          title: Text(
            'Esquema de vacunación',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)
          )
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 90,
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                decoration: BoxDecoration(border: Border(
                  left: BorderSide(width: 15.0, color: Color(0xffFFF087))
                )),
                child: RichText(
                  text: TextSpan(
                    text: 'Aviso: ',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Los elementos en amarillo indican que la vacuna se puede aplicar en cualquiera de los meses en los que aparece.',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)
                      )
                    ]
                  )
                )
              ),
            ),
            _StickyHeaderList(index: 0, data: vaccines[0]),
            _StickyHeaderList(index: 1, data: vaccines[1]),
            _StickyHeaderList(index: 2, data: vaccines[2]),
            _StickyHeaderList(index: 3, data: vaccines[3]),
            _StickyHeaderList(index: 4, data: vaccines[4]),
            _StickyHeaderList(index: 5, data: vaccines[5]),
            _StickyHeaderList(index: 6, data: vaccines[6]),
            _StickyHeaderList(index: 7, data: vaccines[7]),
            _StickyHeaderList(index: 8, data: vaccines[8]),
            _StickyHeaderList(index: 9, data: vaccines[9]),
            _StickyHeaderList(index: 10, data: vaccines[10]),
          ],
        )
      ),
    );
  }
}

class _StickyHeaderList extends StatelessWidget {
  const _StickyHeaderList({
    @required this.index,
    @required this.data
  });

  final Map<String, dynamic> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        color: ThemeManager.getAccentColor(), 
        child: Text(data['title'], style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => ListTile(
            tileColor: data['children'][i]['yellow'] ? Color(0xffFFF087) : Colors.white,
            leading: CircleAvatar(backgroundColor: ThemeManager.getPrimaryColor(), child: Text('${i + 1}')),
            title: Text(data['children'][i]['title']),
          ),
          childCount: data['children'].length
        ),
      ),
    );
  }
}

