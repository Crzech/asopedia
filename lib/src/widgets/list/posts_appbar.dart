import 'package:asopedia/src/widgets/shared/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:asopedia/src/bloc/list/list_cubit.dart';

class PostsAppBar extends StatelessWidget {
  const PostsAppBar({
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
        BlocBuilder<ListCubit, ListState>(
          builder: (context, state) {
            print(state);
            return Text(state.title,
              style: TextStyle(color: Colors.white, fontSize: 20.0)
            );
          },
        ),
        GestureDetector(
          child: Icon(Icons.search, color: Colors.white), 
          onTap: () => showSearch(context: context, delegate: CustomSearchDelegate())
        )
      ],
    );
  }
}
