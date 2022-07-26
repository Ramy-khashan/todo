import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/board/board_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'cubit/adding_task_cubit/adding_task_cubit.dart';
import 'cubit/board_page_cubit/board_page_cubit.dart';
import 'cubit/todo_app_cubit/todo_cubit_cubit.dart';

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoCubitCubit()..initialDatabase()),
        BlocProvider(create: (context) => BoardPageCubit()),
        BlocProvider(create: (context) => AddingTaskCubit()..initialColor()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo Application',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700,
            ),
            bodyText1: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        home: const BoardPageScreen(),
      ),
    );
  }
}
