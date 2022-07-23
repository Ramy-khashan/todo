import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/addtask_data.dart';
import 'package:todo/presentation/adding_task/widget/get_date.dart';
import 'package:todo/presentation/adding_task/widget/get_title.dart';
import 'package:todo/presentation/adding_task/widget/pick_color.dart';
import 'package:todo/presentation/adding_task/widget/start_end_time.dart';

import '../../cubit/adding_task_cubit/adding_task_cubit.dart';
import '../../cubit/adding_task_cubit/adding_task_state.dart';
import '../../cubit/todo_app_cubit/todo_cubit_cubit.dart';
import '../../cubit/todo_app_cubit/todo_cubit_state.dart';
import '../share_widget/button.dart';
import 'widget/dropdown_list.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      body: BlocBuilder<AddingTaskCubit, AddingTaskState>(
        builder: (context, state) {
          final controller = AddingTaskCubit.get(context);
          return Form(
            key: controller.formKey,
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                    EdgeInsets.symmetric(horizontal: size.shortestSide * .05),
                child: Column(
                  children: [
                    GetTitleItem(
                        onChange: (val) {
                          controller.onChangeTextFieldLan(val);
                        },
                        align: controller.titleLan,
                        controller: controller.taskController,
                        head: "Title",
                        onValid: (String valid) {
                          if (valid.isEmpty) {
                            return "Must enter task title";
                          }
                          return null;
                        },
                        size: size),
                    GetDateItem(
                        date: controller.deadLine
                            .toLocal()
                            .toString()
                            .substring(0, 10),
                        head: "Deadline",
                        ontap: () {
                          controller.getDate(context);
                        },
                        size: size),
                    Row(
                      children: [
                        StartEndTimeItem(
                            head: "Start time",
                            time: controller.startTime.format(context),
                            onTap: () {
                              controller.getTime(context, "start");
                            },
                            size: size),
                        SizedBox(width: size.shortestSide * .03),
                        StartEndTimeItem(
                            head: "End time",
                            time: controller.endTime.format(context),
                            onTap: () {
                              controller.getTime(context, "end");
                            },
                            size: size),
                      ],
                    ),
                    DropDownListItem(
                      onChange: (val) {
                        controller.getRemiderRepeatValue(val, "reminder");
                      },
                      listType: AddTaskData.reminder,
                      head: "Reminder",
                      reminderValue: controller.reminderValue,
                      size: size,
                    ),
                    DropDownListItem(
                      head: "Repeat",
                      onChange: (val) {
                        controller.getRemiderRepeatValue(val, "repeat");
                      },
                      listType: AddTaskData.repeat,
                      reminderValue: controller.repeatValue,
                      size: size,
                    ),
                    PickColorItem(
                      onChangeBG: () {
                        controller.showColorPicker(context, isText: false);
                      },
                      onChangeText: () {
                        controller.showColorPicker(context, isText: true);
                      },
                      size: size,
                      colorBg: controller.pickerBGColor,
                      colorText: controller.pickerTextColor,
                    ),
                    BlocBuilder<TodoCubitCubit, TodoCubitState>(
                      builder: (context, state) {
                        final todoController = TodoCubitCubit.get(context);
                        return ButtonItem(
                          head: "Create a task",
                          onPress: () {
                            if (controller.formKey.currentState!.validate()) {
                              todoController.insertNote(
                                  task: controller.taskController.text,
                                  endTime: controller.endTime.format(context),
                                  startTime:
                                      controller.startTime.format(context),
                                  deadLine: controller.deadLine
                                      .toLocal()
                                      .toString()
                                      .substring(0, 10),
                                  repeat: controller.repeatValue,
                                  reminder: controller.reminderValue,
                                  value: 0,
                                  bgColor: controller.pickerBGColor
                                      .toString()
                                      .substring(6, 16),
                                  textColor: controller.pickerTextColor
                                      .toString()
                                      .substring(6, 16),
                                  favorite: 0,
                                  addedAt:
                                      DateFormat.yMd().format(DateTime.now()));
                              Navigator.pop(context);
                            }
                          },
                          size: size,
                          isNeedMargin: false,
                        );
                      },
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
