import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_app/shared/Component.dart';
import 'package:todo/todo_app/shared/Cubit.dart';
import 'package:todo/todo_app/shared/State.dart';

class TasksClass extends StatefulWidget {
  @override
  _TasksClassState createState() => _TasksClassState();
}

class _TasksClassState extends State<TasksClass> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (BuildContext context, AppState state) {},
      builder: (BuildContext context, AppState state) {
        AppCubit cubit = AppCubit.get(context);
        var tasks = AppCubit.get(context).newTasks;
        return tasks.length > 0
            ? ListView.separated(
                itemBuilder: (ctx, index) =>
                    buildTaskItem(cubit.newTasks[index], context),
                separatorBuilder: (ctx, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey,
                ),
                itemCount: cubit.newTasks.length,
              )
            : cubit.buildEmptyScreen(tasks: tasks, text: 'NO Tasks Yet!', icon: Icons.menu,);
      },
    );
  }
}

