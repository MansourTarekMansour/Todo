import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_app/shared/Component.dart';
import 'package:todo/todo_app/shared/Cubit.dart';
import 'package:todo/todo_app/shared/State.dart';

class DoneClass extends StatefulWidget {
  @override
  _DoneClassState createState() => _DoneClassState();
}

class _DoneClassState extends State<DoneClass> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (BuildContext context, AppState state) {},
      builder: (BuildContext context, AppState state) {
        AppCubit cubit = AppCubit.get(context);
        var tasks = AppCubit.get(context).doneTasks;
        return tasks.length > 0
            ? ListView.separated(
                itemBuilder: (ctx, index) =>
                    buildTaskItem(cubit.doneTasks[index], context),
                separatorBuilder: (ctx, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey,
                ),
                itemCount: cubit.doneTasks.length,
              )
            : cubit.buildEmptyScreen(tasks: tasks, text: 'NO Done Tasks Yet!', icon: Icons.check_circle);
      },
    );
  }
}
