class UpdateLectureState {}

class InitState extends UpdateLectureState {}

class LoadingState extends UpdateLectureState {}

class UpdateLectureDone extends UpdateLectureState {
  late bool connection;
  late bool res;
  UpdateLectureDone({required this.connection, required this.res});
}
