class SaveResultState {}

class InitState extends SaveResultState {}

class LoadingState2 extends SaveResultState {}

class SaveDone extends SaveResultState {
  late bool connection;
  late bool res;
  SaveDone({required this.connection, required this.res});
}


