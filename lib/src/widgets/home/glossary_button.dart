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
        listBloc.setGlossaryAsGetter();
        Navigator.pushNamed(
          context, 
          'list', 
          arguments: ListPageArguments(
            categoriesFuture: getMainCategories(),
            postFuture: PostService.getPostsByCategoryId,
          )
        );
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
                Text('Glosario',
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                Text('Contenido General',
                    style: TextStyle(color: Colors.grey, fontSize: 15.0))
              ],
            ),
            Expanded(child: SizedBox()),
            Icon(Icons.menu_book, size: 60, color: Colors.white70)
          ],
        ),
        height: screenSize.width * 0.30,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xff155682),
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
      ),
    );
  }
}