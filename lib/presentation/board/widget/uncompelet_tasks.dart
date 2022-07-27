import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/todo_app_cubit/todo_cubit.dart';
import '../../../cubit/todo_app_cubit/todo_state.dart';
import '../../share_widget/empty_shape.dart';
import 'taskshape.dart';

class UncompeletedTasksItem extends StatelessWidget {
  final Size size;
  const UncompeletedTasksItem({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubitCubit, TodoCubitState>(
      builder: (context, state) {
        final todoController = TodoCubitCubit.get(context);
        return todoController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : todoController.todoUncompelet.isEmpty
                ? EmptyShape(head: "No UnCompleted Tasks", size: size)
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TaskShapeItem(
                        lan: todoController.todoUncompelet[todoController.todoUncompelet.length -
                                      1 -
                                      index].lanType,
                        color: todoController
                            .todoUncompelet[
                                todoController.todoUncompelet.length -
                                    1 -
                                    index]
                            .bgColor,
                        onFavorite: () {
                          todoController.updateTask(
                              task: todoController.todoUncompelet[
                                  todoController.todoUncompelet.length -
                                      1 -
                                      index],
                              favorite: 1,
                              isFavorite: true);
                        },
                        isFavorite: todoController
                            .todoUncompelet[
                                todoController.todoUncompelet.length -
                                    1 -
                                    index]
                            .favorite,
                        size: size,
                        onClick: (val) {
                          todoController.updateTask(
                              task: todoController.todoUncompelet[
                                  todoController.todoUncompelet.length -
                                      1 -
                                      index],
                              value: 1,
                              isFavorite: false);
                        },
                        isDone: todoController
                                    .todoUncompelet[
                                        todoController.todoUncompelet.length -
                                            1 -
                                            index]
                                    .value ==
                                0
                            ? false
                            : true,
                        task: todoController
                            .todoUncompelet[
                                todoController.todoUncompelet.length -
                                    1 -
                                    index]
                            .task,
                      );
                    },
                    itemCount: todoController.todoUncompelet.length,
                  );
      },
    );
  }
}
