import 'package:alwastia/bloc/teacher/gethomeworks/model.dart';

class GetHomeWorkState {}

class InitState extends GetHomeWorkState {}

class LoadingState2 extends GetHomeWorkState {}

class MyHomeWork extends GetHomeWorkState {
  late bool connection;
  late List<HomeWorkModel> data;
  late List<bool> Isclicked;
  MyHomeWork(
      {required this.data, required this.connection, required this.Isclicked});
}
