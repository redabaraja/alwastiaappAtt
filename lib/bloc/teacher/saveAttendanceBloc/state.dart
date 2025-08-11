class SaveAttendanceState {}

class InitState extends SaveAttendanceState {}

class LoadingState2 extends SaveAttendanceState {}

class SaveDone extends SaveAttendanceState {
  late bool connection;
  late bool res;
  SaveDone({required this.connection, required this.res});
}


