import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/todo_app_cubit/todo_cubit.dart';
import '../../../cubit/todo_app_cubit/todo_state.dart';
import '../../share_widget/empty_shape.dart';
import 'taskshape.dart';

class FavoriteTasksItem extends StatelessWidget {
  final Size size;
  const FavoriteTasksItem({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubitCubit, TodoCubitState>(
      builder: (context, state) {
        final todoController = TodoCubitCubit.get(context);
        return todoController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : todoController.todoFavorite.isEmpty
                ? EmptyShape(head: "No Favorite Tasks", size: size)
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TaskShapeItem(
                        lan: todoController.todoFavorite[ todoController.todoFavorite.length - 1 - index].lanType,
                        color: todoController
                            .todoFavorite[
                                todoController.todoFavorite.length - 1 - index]
                            .bgColor,
                        size: size,
                        isFavorite: todoController
                            .todoFavorite[
                                todoController.todoFavorite.length - 1 - index]
                            .favorite,
                        onClick: (val) {
                          if (todoController
                                  .todoFavorite[
                                      todoController.todoFavorite.length -
                                          1 -
                                          index]
                                  .value ==
                              0) {
                            todoController.updateTask(
                                task: todoController.todoFavorite[
                                    todoController.todoFavorite.length -
                                        1 -
                                        index],
                                value: 1,
                                isFavorite: false);
                          } else {
                            todoController.updateTask(
                                task: todoController.todoFavorite[
                                    todoController.todoFavorite.length -
                                        1 -
                                        index],
                                value: 0,
                                isFavorite: false);
                          }
                        },
                        isNeedFavorite: false,
                        onFavorite: () {
                          todoController.updateTask(
                              task: todoController.todoFavorite[
                                  todoController.todoFavorite.length -
                                      1 -
                                      index],
                              favorite: 0,
                              isFavorite: true);
                        },
                        isDone: todoController
                                    .todoFavorite[
                                        todoController.todoFavorite.length -
                                            1 -
                                            index]
                                    .value ==
                                0
                            ? false
                            : true,
                        task: todoController
                            .todoFavorite[
                                todoController.todoFavorite.length - 1 - index]
                            .task,
                      );
                    },
                    itemCount: todoController.todoFavorite.length,
                  );
      },
    );
  }
}
