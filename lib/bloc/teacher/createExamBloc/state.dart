class CreateExamState {}

class InitState extends CreateExamState {}

class LoadingState extends CreateExamState {}

class CreateExamDone extends CreateExamState {
  late bool connection;
  late bool res;
  CreateExamDone({required this.connection, required this.res});
}
