class CreateNotiState {}

class InitState extends CreateNotiState {}

class LoadingState extends CreateNotiState {}

class CreateNotiDone extends CreateNotiState {
  late bool connection;
  late bool res;
  CreateNotiDone({required this.connection, required this.res});
}
