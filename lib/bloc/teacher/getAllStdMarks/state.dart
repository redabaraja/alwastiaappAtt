import 'package:alwastia/bloc/teacher/getMyStudents.dart/model.dart';
import 'package:alwastia/bloc/teacher/getAllStdMarks/model.dart';

class GetAllStdMarksState {}

class InitState extends GetAllStdMarksState {}

class LoadingState extends GetAllStdMarksState {}

class GetAllSTdMarksDone extends GetAllStdMarksState {
  late bool connection;
  late List<MarksModel> data;
  GetAllSTdMarksDone({required this.data, required this.connection});
}

class MyNewStudentsAttendance extends GetAllStdMarksState {
  late bool connection;
  late List<StudentModel> data;
  MyNewStudentsAttendance({required this.data, required this.connection});
}
