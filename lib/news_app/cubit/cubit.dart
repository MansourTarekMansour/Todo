import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/news_app/cubit/states.dart';
import 'package:todo/news_app/modules/business/business_screen.dart';
import 'package:todo/news_app/modules/science/sciense_screen.dart';
import 'package:todo/news_app/modules/settings_screen/SettingsScreen.dart';
import 'package:todo/news_app/modules/sports/sports_screen.dart';
import 'package:todo/news_app/network/local/cache_helper.dart';
import 'package:todo/news_app/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int index = 0;
  List<Map<String, Object>> screens = [
    {'page': BusinessScreen(), 'bar': "Business"},
    {'page': SportsScreen(), 'bar': "Sports"},
    {'page': ScienceScreen(), 'bar': "Science"},
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItem = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: "Science",
    ),
  ];

  void changeIndex(value) {
    index = value;
    if (value == 1)
      getSports();
    else if (value == 2) getScience();
    emit(NewsButtonNavStates());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getDat(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': 'dfa4a6452ef94a86aab950c7ed4c7469',
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getDat(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': 'dfa4a6452ef94a86aab950c7ed4c7469',
      }).then((value) {
        sports = value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getDat(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': 'dfa4a6452ef94a86aab950c7ed4c7469',
      }).then((value) {
        science = value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getDat(url: 'v2/top-headlines', query: {
      'q': '$value',
      'apiKey': 'dfa4a6452ef94a86aab950c7ed4c7469',
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error));
    });
  }


  bool isDark = false;

  void changeMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) => emit(NewsChangeModeState()));
    }
  }
}
