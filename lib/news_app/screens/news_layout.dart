import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/news_app/cubit/cubit.dart';
import 'package:todo/news_app/cubit/states.dart';
import 'package:todo/news_app/modules/search/search_screen.dart';
import 'package:todo/news_app/shared/Component.dart';

class NewsLayout extends StatefulWidget {
  @override
  _NewsLayoutState createState() => _NewsLayoutState();
}

class _NewsLayoutState extends State<NewsLayout> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, NewsStates state) {},
      builder: (BuildContext context, NewsStates state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.screens[cubit.index]['bar'],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),
                onPressed: () => NewsCubit.get(context).changeMode(),
              ),
            ],
          ),
          body: cubit.screens[cubit.index]['page'],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) => cubit.changeIndex(value),
            currentIndex: cubit.index,
            selectedItemColor: Colors.red,
            items: cubit.bottomNavigationBarItem,
          ),
        );
      },
    );
  }
}
