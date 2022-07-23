import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../share_widget/empty_shape.dart';
import 'taskshape.dart';

import '../../../cubit/todo_app_cubit/todo_cubit_cubit.dart';
import '../../../cubit/todo_app_cubit/todo_cubit_state.dart';

class AllTasksItem extends StatelessWidget {
  final Size size;
  const AllTasksItem({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubitCubit, TodoCubitState>(
      builder: (context, state) {
        final todoController = TodoCubitCubit.get(context);
        return todoController.todos.isEmpty
            ? EmptyShape(head: "No Tasks", size: size)
            : ListView.builder(
                itemBuilder: (context, index) {
                  return TaskShapeItem(
                    isFavorite: todoController
                        .todos[todoController.todos.length - 1 - index]
                        .favorite,
                    color: todoController
                        .todos[todoController.todos.length - 1 - index].bgColor,
                    onFavorite: () {
                      todoController.updateTask(
                          task: todoController
                              .todos[todoController.todos.length - 1 - index],
                          favorite: 1,
                          isFavorite: true);
                    },
                    size: size,
                    onClick: (val) {
                      if (todoController
                              .todos[todoController.todos.length - 1 - index]
                              .value ==
                          0) {
                        todoController.updateTask(
                            task: todoController
                                .todos[todoController.todos.length - 1 - index],
                            value: 1,
                            isFavorite: false);
                      } else {
                        todoController.updateTask(
                            task: todoController
                                .todos[todoController.todos.length - 1 - index],
                            value: 0,
                            isFavorite: false);
                      }
                    },
                    isDone: todoController
                                .todos[todoController.todos.length - 1 - index]
                                .value ==
                            0
                        ? false
                        : true,
                    task: todoController
                        .todos[todoController.todos.length - 1 - index].task,
                  );
                },
                itemCount: todoController.todos.length,
              );
      },
    );
  }
}
