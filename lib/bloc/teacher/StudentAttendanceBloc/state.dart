

import 'package:alwastia/bloc/teacher/StudentAttendanceBloc/model.dart';

class OneStudentAttendanceState {}

class InitState extends OneStudentAttendanceState {}

class LoadingState extends OneStudentAttendanceState {}

class MyOneStudentAttendance extends OneStudentAttendanceState {
  late bool connection;
  late List<OneStudentAttendanceModel> data;
  MyOneStudentAttendance({required this.data, required this.connection});
}
