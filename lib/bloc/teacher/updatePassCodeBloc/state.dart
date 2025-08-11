class UpdatePassCodeState {}

class InitState extends UpdatePassCodeState {}

class LoadingState extends UpdatePassCodeState {}

class UpdatePassCodeDone extends UpdatePassCodeState {
  late bool connection;
  late bool res;
  UpdatePassCodeDone({required this.connection, required this.res});
}
