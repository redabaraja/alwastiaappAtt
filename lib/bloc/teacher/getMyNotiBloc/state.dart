import 'package:alwastia/bloc/teacher/getMyNotiBloc/model.dart';

class GetNotisState {}

class InitState extends GetNotisState {}

class LoadingState2 extends GetNotisState {}

class MyNotis extends GetNotisState {
  late bool connection;
  late List<NotiModel> data;
  late List<bool> Isclicked;
  MyNotis({required this.data, required this.connection,required this.Isclicked});
}
