import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/todo_app_cubit/todo_cubit_cubit.dart';
import '../../../cubit/todo_app_cubit/todo_cubit_state.dart';

import '../../share_widget/empty_shape.dart';
import 'taskshape.dart';

class CompeletedTasksItem extends StatelessWidget {
  final Size size;
  const CompeletedTasksItem({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubitCubit, TodoCubitState>(
      builder: (context, state) {
        final todoController = TodoCubitCubit.get(context);
        return todoController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : todoController.todoCompelet.isEmpty
            ? EmptyShape(head: "No Compeleted Tasks", size: size)
            : ListView.builder(
                itemBuilder: (context, index) {
                  return TaskShapeItem(
                        isFavorite: todoController.todoCompelet[todoController.todoCompelet.length - 1 - index].favorite,

                    onFavorite: () {
                      todoController.updateTask(
                          task: todoController.todoCompelet[todoController.todoCompelet.length - 1 - index],
                          favorite: 1,
                          isFavorite: true);
                    },
                    size: size,color: todoController.todoCompelet[todoController.todoCompelet.length - 1 - index].bgColor,
                    onClick: (val) {
                     
                        todoController.updateTask(
                            task: todoController.todoCompelet[todoController.todoCompelet.length - 1 - index],
                            value: 0,
                            isFavorite: false);
                      
                    },
                    isDone: todoController.todoCompelet[todoController.todoCompelet.length - 1 - index].value == 0
                        ? false
                        : true,
                    task: todoController.todoCompelet[todoController.todoCompelet.length - 1 - index].task,
                  );
                },
                itemCount: todoController.todoCompelet.length,
              );
      },
    );
  }
}
