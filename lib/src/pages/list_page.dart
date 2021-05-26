import 'package:asopedia/src/models/categories/main_category.dart';
import 'package:asopedia/src/models/shared/dropdown_item.dart';
import 'package:asopedia/src/services/categories/main_categories_service.dart';
import 'package:asopedia/src/widgets/shared/future_dropdown.dart';
import 'package:flutter/material.dart';

import 'package:asopedia/src/widgets/shared/sliver_header_delegate.dart';

class ListPage extends StatefulWidget {
  
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<List<DropdownItem>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = getMainCategories();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          floating: true,
          delegate: SliverHeaderCustomHeaderDelegate(
            minHeight: screenSize.height * 0.20,
            maxHeight: screenSize.height * 0.25,
            child: Container(
              color: Color(0xff155682),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _AppBar(),
                  SizedBox(height: 25.0),
                  FutureDropdown(future: futureCategories, onChanged: (value) => print(value)),
                  SizedBox(height: 20.0),
                ],
              ),
            )
          ),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return Container(
            height: 150.0,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xff959595))),
              color: Colors.white,
            ),
          );
        }, childCount: 20))
      ],
    ));
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
          onTap: () => Navigator.of(context).pop(),
        ),
        Text('Glosario',
            style:
                TextStyle(color: Colors.white, fontSize: 20.0)),
        Icon(Icons.search, color: Colors.white)
      ],
    );
  }
}