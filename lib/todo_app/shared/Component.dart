import 'package:flutter/material.dart';
import 'Cubit.dart';



Widget buildTaskItem(Map task, context) => Dismissible(
  key: Key(task['id'].toString()),
  child: Padding(
  padding: const EdgeInsets.all(11.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40.0,
        child: Text('${task['time']}'),
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${task['title']}",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${task['date']}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: 30,
      ),
      IconButton(
        icon: Icon(
          Icons.check_box,
          color: Colors.green,
        ),
        onPressed: (){
          AppCubit.get(context).updateDatabase(status: "done", id: task['id']);
        },
      ),

      IconButton(
        icon: Icon(
          Icons.archive_outlined,
        ),
        onPressed: (){
          AppCubit.get(context).updateDatabase(status: "archive", id: task['id']);
        },
      ),

    ],
  ),
  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteDatabase(id: task['id']);
  },
);
