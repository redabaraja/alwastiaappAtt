
class CloseClassState {}

class InitState extends CloseClassState {}

class LoadingState2 extends CloseClassState {}

class CloseState extends CloseClassState {
  late bool connection;
  late bool res;
  CloseState({required this.res, required this.connection});
}
