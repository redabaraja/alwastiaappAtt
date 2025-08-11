import 'package:alwastia/bloc/teacher/getMyStudents.dart/model.dart';
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/model.dart';
import 'package:alwastia/bloc/teacher/getStudentsMarks/model.dart';
import 'package:alwastia/bloc/teacher/getStudentsMarks/model2.dart';

class GetMarksState {}

class InitState extends GetMarksState {}

class LoadingState extends GetMarksState {}

class GetMarksDone extends GetMarksState {
  late bool connection;
  late ResultModel? data;
  GetMarksDone({required this.data, required this.connection});
}

class MyNewStudentsAttendance extends GetMarksState {
  late bool connection;
  late List<StudentModel> data;
  MyNewStudentsAttendance({required this.data, required this.connection});
}
