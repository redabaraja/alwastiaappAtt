
class CloseStdState {}

class InitState extends CloseStdState {}

class LoadingState3 extends CloseStdState {}

class CloseState extends CloseStdState {
  late bool connection;
  late bool res;
  CloseState({required this.res, required this.connection});
}
