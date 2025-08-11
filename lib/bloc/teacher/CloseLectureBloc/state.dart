
class CloseLectureState {}

class InitState extends CloseLectureState {}

class LoadingState3 extends CloseLectureState {}

class CloseState extends CloseLectureState {
  late bool connection;
  late bool res;
  CloseState({required this.res, required this.connection});
}
