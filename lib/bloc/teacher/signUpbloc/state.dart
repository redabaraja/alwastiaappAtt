class TSignUpState {}

class InitState extends TSignUpState {}

class LoadingState extends TSignUpState {}

class Signed extends TSignUpState {
  late bool connection;
  late bool res;
  Signed({required this.connection, required this.res});
}
