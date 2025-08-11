import 'package:alwastia/bloc/teacher/getMyStudents.dart/model.dart';
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/model.dart';
import 'package:alwastia/bloc/student/getStdMarks/model.dart';

class GetStdMarksState {}

class InitState extends GetStdMarksState {}

class LoadingState extends GetStdMarksState {}

class GetMarksDone extends GetStdMarksState {
  late bool connection;
  late List<MarksModelMain> data;
  GetMarksDone({required this.data, required this.connection});
}

// class MyNewStudentsAttendance extends GetStdMarksState {
//   late bool connection;
//   late List<StudentModel> data;
//   MyNewStudentsAttendance({required this.data, required this.connection});
// }
