import 'package:alwastia/bloc/teacher/getHomeWorkStdBloc/model.dart';

class GetHomeWorkStudentsState {}

class InitState extends GetHomeWorkStudentsState {}

class LoadingState extends GetHomeWorkStudentsState {}

class MyHomeWorkStudents extends GetHomeWorkStudentsState {
  late bool connection;
  late List<HomeWorkStudentModel> data;
  late List<bool> fileExsit;
  late List<String> filePath;
  MyHomeWorkStudents(
      {required this.data,
      required this.connection,
      required this.fileExsit,
      required this.filePath});
}
