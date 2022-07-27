import 'package:flutter/material.dart';
import 'package:todo/models/db_model.dart';

class TaskShapeScheduleItem extends StatelessWidget {
  final Size size;
  final TaskModel task;
  const TaskShapeScheduleItem(
      {Key? key, required this.task, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.longestSide * .015),
      margin: EdgeInsets.symmetric(
          horizontal: size.shortestSide * .025,
          vertical: size.longestSide * .01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(int.parse(task.bgColor)),
      ),
      child: ListTile(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "${task.endTime}\n"),
              TextSpan(
                text: task.task,
              )
            ],
            style: TextStyle(
                color: Color(int.parse(task.textColor)),
                fontSize: size.shortestSide * .045,
                fontWeight: FontWeight.w700),
          ),
          textAlign: task.lanType == "ar" ? TextAlign.right : TextAlign.left,
        ),
        trailing: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              border:
                  Border.all(width: 2, color: Color(int.parse(task.textColor))),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.done,
                color: task.value == 1
                    ? Color(int.parse(task.textColor))
                    : Color(int.parse(task.bgColor)))),
      ),
    );
  }
}
