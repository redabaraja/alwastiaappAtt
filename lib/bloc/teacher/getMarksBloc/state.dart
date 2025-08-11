import 'package:alwastia/bloc/teacher/getMyStudents.dart/model.dart';
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/model.dart';

class GetClassStudentsAttendanceState {}

class InitState extends GetClassStudentsAttendanceState {}

class LoadingState extends GetClassStudentsAttendanceState {}

class MyStudentsAttendance extends GetClassStudentsAttendanceState {
  late bool connection;
  late List<StudentAttendanceModel> data;
  MyStudentsAttendance({required this.data, required this.connection});
}

class MyNewStudentsAttendance extends GetClassStudentsAttendanceState {
  late bool connection;
  late List<StudentModel> data;
  MyNewStudentsAttendance({required this.data, required this.connection});
}
