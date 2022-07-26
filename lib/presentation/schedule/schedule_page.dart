import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/cubit/schedual/schedual_cubit.dart';
import 'package:todo/presentation/adding_task/widget/head.dart';
import 'package:todo/presentation/schedule/widget/date_filter.dart';
import 'package:todo/presentation/schedule/widget/task_shape.dart';
import '../../cubit/schedual/schedual_state.dart';
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
          return BlocProvider(
            create: (context) => SchedualCubit()
              ..getTasksInchoosenDay(
                  index: DateTime(DateTime.now().year, DateTime.now().month,
                          DateTime.now().day)
                      .day,
                  todos: todoController.todos)
              ..getCurrentDay(),
            child: BlocBuilder<SchedualCubit, SchedualState>(
              builder: (context, state) {
                final controller = SchedualCubit.get(context);
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: DateTime(DateTime.now().year,
                                DateTime.now().month + 1, 0)
                            .day,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            controller.onGetDay(index + 1);
                            controller.todoTasks = [];
                            controller.getTasksInchoosenDay(
                                index: index, todos: todoController.todos);
                          },
                          child: CurrentDayITem(
                            dayName: DateFormat.E()
                                .format(DateTime(DateTime.now().year,
                                    DateTime.now().month, index + 1))
                                .toUpperCase(),
                            dayNum: "${index + 1}",
                            isToday: index + 1 == controller.choosenDay,
                            size: size,
                          ),
                        ),
                      ),
                    ),
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
                            head:
                                DateFormat(("d MMM, y")).format(DateTime.now()),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: controller.todoTasks.isEmpty
                          ? EmptyShape(
                              head: DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day)
                                          .day ==
                                      controller.choosenDay
                                  ? "No Tasks Today"
                                  : "No tasks in this day",
                              size: size)
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return TaskShapeScheduleItem(
                                  task: controller.todoTasks[index],
                                  size: size,
                                );
                              },
                              itemCount: controller.todoTasks.length,
                            ),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
