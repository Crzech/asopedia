import 'package:asopedia/src/themes/theme_manager.dart';
import 'package:asopedia/src/widgets/shared/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asopedia/src/bloc/list/list_cubit.dart';

class PostsAppBar extends StatelessWidget {
  const PostsAppBar({
    @required this.screenSize,
  });

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListCubit, ListState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(top: screenSize.height * 0.06, right: 20.0, left: 20.0),
          height: screenSize.height * 0.25,
          width: screenSize.width,
          color: ThemeManager.getPrimaryColor(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Icon(Icons.arrow_back_ios, color: Colors.white),
                onTap: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: Text(
                  state.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)
                ),
              ),
              GestureDetector(
                child: Icon(Icons.search, color: Colors.white),
                onTap: () => showSearch(
                  context: context, 
                  delegate: CustomSearchDelegate(categoryId: state.selectedCat)
                )
              ),
            ],
          ),
        );
      },
    );
  }
}
