class UploadHomeWorkState {}

class InitState extends UploadHomeWorkState {}

class LoadingState3 extends UploadHomeWorkState {}

class UploadHomeWorkDone extends UploadHomeWorkState {
  late bool connection;
  late bool res;
  UploadHomeWorkDone({required this.connection, required this.res});
}

class GetFileDone extends UploadHomeWorkState {
  late String filePath;
  late String name;
  late int ext;
  late int assignment;
  late int index;
  GetFileDone(
      {required this.filePath,
      required this.name,
      required this.ext,
      required this.assignment,
      required this.index});
}
