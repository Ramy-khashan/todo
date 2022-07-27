import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/db_model.dart';
import 'schedual_state.dart';

class SchedualCubit extends Cubit<SchedualState> {
  SchedualCubit() : super(SchedualInitial());
  static SchedualCubit get(ctx) => BlocProvider.of(ctx);
  List<TaskModel> todoTasks = [];
  int choosenDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .day;
  getCurrentDay() {
    choosenDay =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .day;
  }

  getTasksInchoosenDay({index, todos}) {
    for (var element in todos) {
      if (element.addedAt ==
              DateFormat.yMd().format(
                  DateTime(DateTime.now().year, DateTime.now().month, index)) ||
          (element.isRepeat == 1 &&
              int.parse(element.addedAt.toString().split('/')[1]) <= index)) {
        log(element.addedAt.toString().split('/')[1]);
        todoTasks.add(element);
      }
    }
    emit(GetTasksState());
  }

  onGetDay(int day) {
    choosenDay = day;
    emit(GetChoosenDayState());
  }
}
