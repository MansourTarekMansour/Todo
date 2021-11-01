import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/news_app/cubit/cubit.dart';
import 'package:todo/news_app/cubit/states.dart';
import 'package:todo/news_app/shared/Component.dart';
import 'package:todo/todo_app/shared/Cubit.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List search = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) return "search must be not empty";
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: articleBuilder(search, context, isSearch: true),
                ),
              ],
            ),
          );
        }
    );
  }
}
