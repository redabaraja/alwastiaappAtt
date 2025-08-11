class LoginState {}

class InitState extends LoginState {}

class LoadingState extends LoginState {}

class Logined extends LoginState {
  late bool connection;
  late bool res;
  late int type;
  Logined({required this.connection, required this.res, required this.type});
}

class UpdatePassWordDone extends LoginState {
  late bool res;
  late String txt;

  UpdatePassWordDone({required this.res, required this.txt});
}
