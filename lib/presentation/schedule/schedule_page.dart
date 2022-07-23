import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/presentation/adding_task/widget/head.dart';
import 'package:todo/presentation/schedule/widget/date_filter.dart';
import 'package:todo/presentation/schedule/widget/task_shape.dart';

import '../../cubit/todo_app_cubit/todo_cubit_cubit.dart';
import '../../cubit/todo_app_cubit/todo_cubit_state.dart';
import '../share_widget/empty_shape.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Schedule",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      body: BlocBuilder<TodoCubitCubit, TodoCubitState>(
        builder: (context, state) {
          final todoController = TodoCubitCubit.get(context);
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: List.generate(
                      DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
                          .day,
                      (index) => CurrentDayITem(
                            dayName: DateFormat.E()
                                .format(DateTime(DateTime.now().year,
                                    DateTime.now().month, index + 1))
                                .toUpperCase(),
                            dayNum: "${index + 1}",
                            isToday: DateTime.now().day == index + 1,
                            size: size,
                          )),
                ),
              ),
              Column(
                  children: List.generate(
                      todoController.todos.length,
                      (index) =>
                          Text(DateFormat.yMd().format(DateTime.now())))),
              Divider(
                color: Colors.black38,
                thickness: 1.2,
                height: size.longestSide * .02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    HeadItem(
                        size: size,
                        head: DateFormat.EEEE().format(DateTime.now())),
                    const Spacer(),
                    HeadItem(
                      size: size,
                      head: DateFormat.yMMMd().format(DateTime.now()),
                    )
                  ],
                ),
              ),
              Expanded(
                child: todoController.todoToday.isEmpty
                    ? EmptyShape(head: "No Tasks Today", size: size)
                    : ListView.builder(
                        itemBuilder: (context, index) => TaskShapeScheduleItem(
                          task: todoController.todos[index],
                          size: size,
                        ),
                        itemCount: todoController.todos.length,
                      ),
              )
            ],
          );
        },
      ),
    );
  }
}
