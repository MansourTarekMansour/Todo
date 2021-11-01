import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo_app/shared/Component.dart';
import 'package:todo/todo_app/shared/Cubit.dart';
import 'package:todo/todo_app/shared/State.dart';


class ArchivedClass extends StatefulWidget {
  @override
  _ArchivedClassState createState() => _ArchivedClassState();
}

class _ArchivedClassState extends State<ArchivedClass> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (BuildContext context, AppState state) {},
      builder: (BuildContext context, AppState state) {
        AppCubit cubit = AppCubit.get(context);
        var tasks = AppCubit.get(context).archivedTasks;
        return tasks.length > 0
            ? ListView.separated(
                itemBuilder: (ctx, index) =>
                    buildTaskItem(cubit.archivedTasks[index], context),
                separatorBuilder: (ctx, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey,
                ),
                itemCount: cubit.archivedTasks.length,
              )
            : cubit.buildEmptyScreen(tasks: tasks, text: 'No Tasks Archived', icon: Icons.archive_outlined);
      },
    );
  }
}
