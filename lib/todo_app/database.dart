import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/todo_app/shared/Cubit.dart';
import 'package:todo/todo_app/shared/State.dart';


class DataBaseClass extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if(state is AppInsertDatabaseState){
            Navigator.of(context).pop();
          }
        },
        builder: (BuildContext context, AppState state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.appBar[cubit.bottomNavigationBarIndex]),
            ),
            body: state is! AppDatabaseLoaderState
                ? cubit.page[cubit.bottomNavigationBarIndex]
                : Center(child: CircularProgressIndicator()),
            floatingActionButton: FloatingActionButton(
              child: Icon(
                cubit.buttonSheetIcon,
              ),
              onPressed: () {
                if (cubit.buttonValue) {
                  if (formKey.currentState.validate()) {
                    cubit.insertDatabase(
                      title: cubit.titleController.text,
                      date: cubit.dateController.text,
                      time: cubit.timeController.text,
                    );
                    cubit.clearContController();
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet((context) {
                        return Container(
                          width: double.infinity,
                          height: 320,
                          color: Colors.grey[200],
                          padding: EdgeInsets.all(10),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: cubit.titleController,
                                  // kind of keyboard (text, number, email,...)
                                  keyboardType: TextInputType.text,
                                  //obscureText: true,
                                  // have a value which wrote inside
                                  onFieldSubmitted: (String value) {},
                                  onChanged: (value) {},
                                  onTap: () {},
                                  validator: (String value) {
                                    return value.isEmpty
                                        ? "Empty Value!!"
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Task Title",
                                    prefixIcon: Icon(Icons.title),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: cubit.timeController,
                                  // kind of keyboard (text, number, email,...)
                                  keyboardType: TextInputType.text,
                                  // have a value which wrote inside
                                  onFieldSubmitted: (String value) {},
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      cubit.timeController.text =
                                          value.format(context).toString();
                                    }).catchError((error) {});
                                  },
                                  validator: (String value) {
                                    return value.isEmpty
                                        ? "Empty Value!!"
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Task Time",
                                    prefixIcon: Icon(Icons.access_time),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: cubit.dateController,
                                  // kind of keyboard (text, number, email,...)
                                  keyboardType: TextInputType.text,
                                  // have a value which wrote inside
                                  onFieldSubmitted: (String value) {},
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse("2050-01-01"),
                                    ).then((value) {
                                      cubit.dateController.text =
                                          DateFormat.yMMMd()
                                              .format(value)
                                              .toString();
                                    });
                                  },
                                  validator: (String value) {
                                    return value.isEmpty
                                        ? "Empty Value!!"
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: "Task Date",
                                    prefixIcon: Icon(Icons.date_range),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }, elevation: 20.0)
                      .closed
                      .then((value) {
                        cubit.changeButtonValIcon(false, Icons.edit);
                      });
                  cubit.changeButtonValIcon(true, Icons.add);
                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              iconSize: 25,
              selectedFontSize: 15,
              unselectedFontSize: 12,
              currentIndex: cubit.bottomNavigationBarIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment_turned_in),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: "Archived",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
