abstract class TodoCubitState {}

class TodoCubitInitial extends TodoCubitState {}

class InitialDatabaseState extends TodoCubitState {}

class CreateDatabaseState extends TodoCubitState {}

class OpenDatabaseState extends TodoCubitState {}

class SuccesGetTodoListState extends TodoCubitState {}

class InsertTaskToDatabaseState extends TodoCubitState {}

class UpdateTaskToDoneState extends TodoCubitState {}

class LoadingTaskState extends TodoCubitState {}
