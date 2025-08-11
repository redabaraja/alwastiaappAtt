class CreateQuestionState {}

class InitState extends CreateQuestionState {}

class LoadingState extends CreateQuestionState {}

class CreateQuestionDone extends CreateQuestionState {
  late bool connection;
  late bool res;
  CreateQuestionDone({required this.connection, required this.res});
}
