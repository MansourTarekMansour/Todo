import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../todoScreens/archivedClass.dart';
import '../todoScreens/doneClass.dart';
import '../todoScreens/tasksClass.dart';
import 'State.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int bottomNavigationBarIndex = 0;
  Database database;
  bool buttonValue = false;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  IconData buttonSheetIcon = Icons.edit;
  IconData underTextForm = Icons.close;

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  List<Widget> page = [
    TasksClass(),
    DoneClass(),
    ArchivedClass(),
  ];

  List<String> appBar = [
    "Tasks",
    "Done",
    "Archived",
  ];

  Widget buildEmptyScreen({@required List<Map> tasks, @required String text, @required IconData icon,}){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 100.0,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  clearContController(){
    titleController = TextEditingController();
    timeController = TextEditingController();
    dateController = TextEditingController();
  }
  changeIndex(index) {
    bottomNavigationBarIndex = index;
    emit(ChangeButNavBarIndex());
  }

  changeButtonValIcon(bool value, IconData icon) {
    buttonValue = value;
    buttonSheetIcon = icon;
    emit(ChangeButtonValIconState());
  }

  void createDataBase() async {
    openDatabase(
      'database1.db',
      version: 1,
      onCreate: (database, version) {
        print("onCreate");
        database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print("onCreate successful");
        }).catchError((error) {
          print(error.toString());
        });
      },
      onOpen: (database) {
        getDataBase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    }).catchError((error) => print(error));
  }

  insertDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO Tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print("${value.toString()} insert successfully");
        emit(AppInsertDatabaseState());
        getDataBase(database);
      }).catchError((error) {
        print(error.toString());
      });
      return null;
    });
  }

  void getDataBase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppDatabaseLoaderState());
     database.rawQuery('SELECT * FROM Tasks').then((value) {
      print('onOpen successful');
      value.forEach((element){
        print(element);
        if(element['status'] == 'new') newTasks.add(element);
        else if(element['status'] == 'done') doneTasks.add(element);
        else if(element['status'] == 'archive') archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateDatabase({
    @required String status,
    @required int id,
  }) {
    database.rawUpdate('UPDATE Tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value){
          getDataBase(database);
          emit(AppUpdateDatabaseState());
    });
  }

  void deleteDatabase({
    @required int id,
  }) {
    database.rawDelete('DELETE FROM Tasks WHERE id = ?',
        [id]).then((value){
      getDataBase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
