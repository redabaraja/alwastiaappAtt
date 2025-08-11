class CreateHomeWorkState {}

class InitState extends CreateHomeWorkState {}

class LoadingState extends CreateHomeWorkState {}

class CreateHomeWorkDone extends CreateHomeWorkState {
  late bool connection;
  late bool res;
  CreateHomeWorkDone({required this.connection, required this.res});
}
