import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/model.dart';

class AttendanceSummeryState {}

class InitState extends AttendanceSummeryState {}

class LoadingState extends AttendanceSummeryState {}

class LoadingState2 extends AttendanceSummeryState {}

class MyAttendanceSummery extends AttendanceSummeryState {
  late bool connection;
  late List<AttendanceSummeryModel> data;
  MyAttendanceSummery({required this.data, required this.connection});
}

class MyOneAttendanceSummery extends AttendanceSummeryState {
  late bool connection;
  late AttendanceSummeryModel data;
  late List<AttendancedetailsModel> data2;

  MyOneAttendanceSummery(
      {required this.data, required this.connection, required this.data2});
}

class MyOneAttendanceDetials extends AttendanceSummeryState {
  late bool connection;
  late List<AttendancedetailsModel> data;
  MyOneAttendanceDetials({required this.data, required this.connection});
}
