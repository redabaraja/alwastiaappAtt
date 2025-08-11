import 'package:alwastia/bloc/teacher/getMyStudents.dart/model.dart';

class GetClassStudentsState {}

class InitState extends GetClassStudentsState {}

class LoadingState extends GetClassStudentsState {}

class MyStudents extends GetClassStudentsState {
  late bool connection;
  late List<StudentModel> data;
  MyStudents({required this.data, required this.connection});
}
