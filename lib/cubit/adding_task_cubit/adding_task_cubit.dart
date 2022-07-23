import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../data/addtask_data.dart';
import 'adding_task_state.dart';

class AddingTaskCubit extends Cubit<AddingTaskState> {
  AddingTaskCubit() : super(AddingTaskInitial());
  String reminderValue = AddTaskData.reminder[0];
  String repeatValue = AddTaskData.repeat[0];
  final taskController = TextEditingController();
  static AddingTaskCubit get(ctx) => BlocProvider.of(ctx);
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  DateTime deadLine = DateTime.now();
  late Color pickerBGColor;
  late Color pickerTextColor;
  String titleLan = "en";
  List letter = [
    "ئ",
    "ء",
    "ؤ",
    "ر",
    "ى",
    "ة",
    "و",
    "ظ",
    "ط",
    "ك",
    "م",
    "ن",
    "ت",
    "ا",
    "ل",
    "ب",
    "ي",
    "س",
    "ش",
    "د",
    "ج",
    "ح",
    "خ",
    "ه",
    "ع",
    "غ",
    "ف",
    "ق",
    "ث",
    "ص",
    "ض",
    "ذ",
    "~",
    "ْ",
    "لآ",
    "آ",
    "ِ",
    "ٍ",
    "أ",
    "،",
    "؛",
    "‘",
    "ٌ",
    "ُ",
    "ً",
    "َ",
    "ّ"
  ];

  initialColor() {
    pickerBGColor = const Color.fromARGB(250, 0, 0, 0);
    pickerTextColor = const Color.fromARGB(200, 255, 255, 255);
    taskController.clear();
    emit(InitialColorState());
  }

  final formKey = GlobalKey<FormState>();
  getRemiderRepeatValue(value, type) {
    if (type == "reminder") {
      reminderValue = value;
    } else {
      repeatValue = value;
    }
    emit(GetReminderRepeatValueState());
  }

  getTime(context, type) {
    TimeOfDay selectTime = TimeOfDay.now();
    showTimePicker(
      context: context,
      initialTime: selectTime,
      initialEntryMode: TimePickerEntryMode.dial,
    ).then((value) {
      if (type == "start") {
        startTime = value!;
        log(value.period.toString());
      } else if (type == "end") {
        endTime = value!;
        log(value.period.toString());
      }
      emit(GetStartEndTimeState());
    });

    emit(GetTimeValueState());
  }

  getDate(context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2023))
        .then((value) {
      deadLine = value!;

      emit(GetDateValueState());
    });
  }

  void changeBGColor(Color color, bool isText) {
    if (isText) {
      pickerTextColor = color;
    } else {
      pickerBGColor = color;
    }
    emit(PutColorState());
  }

  showColorPicker(context, {required bool isText}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(
                  child:
                      Text(isText ? 'Pick a Text color!' : 'Pick a BG color!')),
              content: SingleChildScrollView(
                child: ColorPicker(
                    pickerColor: isText ? pickerTextColor : pickerBGColor,
                    onColorChanged: (color) {
                      changeBGColor(color, isText);
                    }),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Got it'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  detectLan(String val, String type) {
    for (int i = 0; i < letter.length; i++) {
      if (val.trim()[0].toString() == letter[i]) {
        titleLan = "ar";

        break;
      } else {
        titleLan = "en";
      }
    }
    emit(LanguageState());
  }
  onChangeTextFieldLan(val){if (val.isNotEmpty) {
                            detectLan(val, "head");
                          } else {
                            titleLan = "en";
                            emit(LanguageState());
                          }}
}
