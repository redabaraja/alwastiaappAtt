class CreateFileState {}

class InitState extends CreateFileState {}

class LoadingState extends CreateFileState {}

class CreateFileDone extends CreateFileState {
  late bool connection;
  late bool res;
  CreateFileDone({required this.connection, required this.res});
}

class GetFileDone extends CreateFileState {
  late String filePath;
  late String name;
  late int ext;
  GetFileDone({required this.filePath, required this.name,required this.ext});
}
