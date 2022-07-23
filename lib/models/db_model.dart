class TaskModel {
  late int taskId;
  late String task;
  late int value;
  late String reminder;
  late String repeat;
  late String deadLine;
  late String startTime;
  late String endTime;
  late String textColor;
  late String bgColor;
  late String addedAt;
  late int favorite;

  TaskModel.fromJson(Map<String, dynamic> json) {
    taskId = json["id"];
    task = json["task"];
    value = json["value"];
    reminder = json["reminder"];
    repeat = json["repeat"];
    deadLine = json["deadLine"];
    startTime = json["startTime"];
    endTime = json["endTime"];
    textColor = json["textColor"];
    bgColor = json["bgColor"];
    favorite = json["favorite"];
    addedAt = json["addedAt"];
  }
}
