import 'package:alwastia/bloc/teacher/gethomeworks2/model.dart';

class GetHomeWorkState2 {}

class InitState extends GetHomeWorkState2 {}

class LoadingState2 extends GetHomeWorkState2 {}

class MyHomeWork extends GetHomeWorkState2 {
  late bool connection;
  late List<HomeWorkModel2> data;
  late List<bool> Isclicked;
  MyHomeWork(
      {required this.data, required this.connection, required this.Isclicked});
}
