import 'package:alwastia/bloc/teacher/getMyLecturesBloc/model.dart';

class GetLecturesState {}

class InitState extends GetLecturesState {}

class LoadingState2 extends GetLecturesState {}

class MyLectures extends GetLecturesState {
  late bool connection;
  late List<LectureModel> data;
  MyLectures({required this.data, required this.connection});
}
