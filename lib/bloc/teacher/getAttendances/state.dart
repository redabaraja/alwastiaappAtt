import 'package:alwastia/bloc/teacher/getAttendances/model.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/model.dart';

class GetAttendanceDatesState {}

class InitState extends GetAttendanceDatesState {}

class LoadingState2 extends GetAttendanceDatesState {}

class MyAttendanceDates extends GetAttendanceDatesState {
  late bool connection;
  late List<AtendanceDatesModel> data;
  MyAttendanceDates({required this.data, required this.connection});
}
