import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo/news_app/cubit/states.dart';
import 'package:todo/news_app/network/local/cache_helper.dart';
import 'package:todo/news_app/network/remote/dio_helper.dart';
import 'package:todo/news_app/screens/news_layout.dart';
import 'package:bloc/bloc.dart';
import 'news_app/cubit/cubit.dart';
import 'news_app/shared/observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => NewsCubit()..getBusiness()..getScience()..getSports()..changeMode(fromShared: isDark)),
        ],
        child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News App',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              backgroundColor: HexColor('fafafa'),
              elevation: 20.0,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          darkTheme:  ThemeData(
            scaffoldBackgroundColor: HexColor('313538'),
            primarySwatch: Colors.deepOrange,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,
            ),
            appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('313538'),
                  statusBarIconBrightness: Brightness.light,
                ),
                backgroundColor: HexColor('313538'),
                elevation: 0.0,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              backgroundColor: HexColor('2C2F32'),
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.deepOrange,
              elevation: 20.0,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          themeMode: NewsCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
          home: NewsLayout(),
        ),
      ),
    );
  }
}
