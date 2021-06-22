import 'package:asopedia/src/bloc/list/list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:asopedia/src/pages/list_page.dart';
import 'package:asopedia/src/services/categories/main_categories_service.dart';
import 'package:asopedia/src/services/posts/posts_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class GlossaryButton extends StatelessWidget {
  const GlossaryButton({
    @required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    final listBloc = BlocProvider.of<ListCubit>(context);
    return GestureDetector(
      onTap: () {
        // listBloc.setGlossaryAsGetter();
        // Navigator.pushNamed(
        //   context, 
        //   'list', 
        //   arguments: ListPageArguments(
        //     categoriesFuture: getMainCategories(),
        //     postFuture: PostService.getPostsByCategoryId,
        //     defaultCat: '2'
        //   )
        // );
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Actualidad',
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                Container(
                  width: screenSize.width * 0.60,
                  child:Text(
                    'Tendencias, Anafilaxia, Infectología, COVID19',
                    style: TextStyle(color: Colors.grey, fontSize: 15.0)
                  )
                )
              ],
            ),
            Expanded(child: SizedBox()),
            Icon(Icons.menu_book, size: 60, color: Colors.white70)
          ],
        ),
        height: screenSize.height * 0.20,
        width: screenSize.width * 0.90,
        decoration: BoxDecoration(
            color: Color(0xff155682),
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
      ),
    );
  }
}