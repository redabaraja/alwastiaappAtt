class CreateLectureState {}

class InitState extends CreateLectureState {}

class LoadingState extends CreateLectureState {}

class CreateLectureDone extends CreateLectureState {
  late bool connection;
  late bool res;
  CreateLectureDone({required this.connection, required this.res});
}
