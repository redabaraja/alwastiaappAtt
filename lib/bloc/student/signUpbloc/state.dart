class SignUpState {}

class InitState extends SignUpState {}

class LoadingState extends SignUpState {}

class Signed extends SignUpState {
  late bool connection;
  late bool res;
  Signed({required this.connection, required this.res});
}
