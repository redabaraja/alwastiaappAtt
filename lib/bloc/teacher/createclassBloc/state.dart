class CreateClassState {}

class InitState extends CreateClassState {}

class LoadingState extends CreateClassState {}

class CreateClassDone extends CreateClassState {
  late bool connection;
  late bool res;
  CreateClassDone({required this.connection, required this.res});
}
