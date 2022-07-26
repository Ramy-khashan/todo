import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/db_model.dart';
import 'package:todo/services/notification_service.dart';
import '../../data/addtask_data.dart';
import 'todo_cubit_state.dart';

class TodoCubitCubit extends Cubit<TodoCubitState> {
  TodoCubitCubit() : super(TodoCubitInitial());
  static TodoCubitCubit get(ctx) => BlocProvider.of(ctx);
  late Database database;
  bool isLoading = false;
  List<TaskModel> todos = [];
  List<TaskModel> todoCompelet = [];
  List<TaskModel> todoUncompelet = [];
  List<TaskModel> todoFavorite = [];
  initialDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todoApp.db');
    openDB(path);
    emit(InitialDatabaseState());
  }

  openDB(path) async {
    await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE todo (id INTEGER PRIMARY KEY, task TEXT, value INTEGER,reminder TEXT,repeat TEXT,deadLine TEXT,startTime TEXT,endTime TEXT,bgColor TEXT,textColor TEXT, favorite INTEGER,addedAt TEXT)');
      emit(CreateDatabaseState());
    }, onOpen: (Database db) {
      database = db;
      getTodosList();
      emit(OpenDatabaseState());
    });
  }

  void insertNote(
      {task,
      value,
      reminder,
      repeat,
      deadLine,
      startTime,
      endTime,
      bgColor,
      textColor,
      favorite,
      addedAt}) async {
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO todo (task, value, reminder, repeat,deadLine,startTime,endTime,bgColor,textColor,favorite,addedAt) VALUES(?,?,?,?,?,?,?,?,?,?,?)',
          [
            task,
            value,
            reminder,
            repeat,
            deadLine,
            startTime,
            endTime,
            bgColor,
            textColor,
            favorite,
            addedAt
          ]).then((value) {
        NotificationService().showNotification(
            id: value,
            title: "Remeber Your Task",
            body: task,
            minute: reminder == AddTaskData.reminder[0]
                // AddTaskData.reminder[0] == after one day
                ?( 24 * 60)
                : reminder == AddTaskData.reminder[1]
                    // AddTaskData.reminder[1] == after one hour
                    ? 60
                    : reminder == AddTaskData.reminder[2]
                        // AddTaskData.reminder[2] == after 30 minutes
                        ? 30
                        // AddTaskData.reminder[3] == after 10 minutes
                        : 10);

        Fluttertoast.showToast(msg: "Task Added");
        getTodosList();
        emit(InsertTaskToDatabaseState());
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: "Somethig went wrong try again!");
      });
    });
  }

  updateTask({required TaskModel task, value, favorite, isFavorite}) async {
    await database.rawUpdate(
        'UPDATE todo SET task = ?, value = ?, reminder= ?, repeat= ?, deadLine=? , startTime=?, endTime=?, bgColor=?, textColor=?,favorite=?,addedAt=? WHERE id = ${task.taskId}',
        [
          task.task,
          isFavorite ? task.value : value,
          task.reminder,
          task.repeat,
          task.deadLine,
          task.startTime,
          task.endTime,
          task.bgColor,
          task.textColor,
          isFavorite ? favorite : task.favorite,
          task.addedAt
        ]).then((_) {
      if (!isFavorite) {
        Fluttertoast.showToast(msg: value == 1 ? "Completed" : "Uncompleted");
      } else if (isFavorite) {
        if (favorite == 1 && task.favorite == 1) {
          Fluttertoast.showToast(msg: "Aleady Exsist");
        } else {
          Fluttertoast.showToast(
              msg: favorite == 1 ? "Add to favorite" : "Remove from favorite");
        }
      }
      getTodosList();
      emit(UpdateTaskToDoneState());
    });
  }

  void getTodosList() async {
    isLoading = true;
    emit(LoadingTaskState());
    todoCompelet = [];
    todoUncompelet = [];
    todoFavorite = [];
    await database.rawQuery('SELECT * FROM todo').then((value) {
      todos = value.map((e) => TaskModel.fromJson(e)).toList();
      for (var element in value) {
        if (element['favorite'] == 1) {
          todoFavorite.add(TaskModel.fromJson(element));
        }
        if (element["value"] == 0) {
          todoUncompelet.add(TaskModel.fromJson(element));
        } else if (element["value"] == 1) {
          todoCompelet.add(TaskModel.fromJson(element));
        }
      }
      isLoading = false;
      emit(SuccesGetTodoListState());

      emit(LoadingTaskState());
    });
  }
}
