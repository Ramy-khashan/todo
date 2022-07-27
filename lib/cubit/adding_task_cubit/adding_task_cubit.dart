import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo/presentation/share_widget/button.dart';

import '../../data/addtask_data.dart';
import 'adding_task_state.dart';

class AddingTaskCubit extends Cubit<AddingTaskState> {
  AddingTaskCubit() : super(AddingTaskInitial());
  String reminderValue = AddTaskData.reminder[0];
  String repeatValue = AddTaskData.repeat[1];
  final taskController = TextEditingController();
  static AddingTaskCubit get(ctx) => BlocProvider.of(ctx);
  TimeOfDay endTime =
      TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
  TimeOfDay startTime = TimeOfDay.now();

  DateTime deadLine = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  late Color pickerBGColor;
  late Color pickerTextColor;
  late String titleLan;
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

  initialValues() {
    endTime = TimeOfDay(
        hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
    startTime = TimeOfDay.now();
    deadLine = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    titleLan = "en";
    taskController.clear();
    pickerBGColor = const Color.fromARGB(200, 0, 0, 0);
    pickerTextColor = const Color.fromARGB(150, 240, 220, 200);
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
            initialDate: deadLine,
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

  showColorPicker(context, {required bool isText, required Size size}) {
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
              actions: [
                ButtonItem(
                    head: "Got it",
                    paddingSize: .016,
                    onPress: () {
                      Navigator.of(context).pop();
                    },
                    size: size)
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

  onChangeTextFieldLan(val) {
    if (val.isNotEmpty) {
      detectLan(val, "head");
    } else {
      titleLan = "en";
      emit(LanguageState());
    }
  }
}
