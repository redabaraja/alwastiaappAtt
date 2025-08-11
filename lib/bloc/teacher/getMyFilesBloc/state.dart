import 'package:alwastia/bloc/teacher/getMyFilesBloc/model.dart';

class GetFilesState {}

class InitState extends GetFilesState {}

class LoadingState2 extends GetFilesState {}

class MyFiles extends GetFilesState {
  late bool connection;
  late List<FileModel> data;
  late List<bool> fileExsit;
  late List<String> filePath;
  MyFiles(
      {required this.data,
      required this.connection,
      required this.fileExsit,
      required this.filePath});
}
