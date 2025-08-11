import 'package:equatable/equatable.dart';

class SaveAttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveAttendance extends SaveAttendanceEvent {
  late String lectureId;
  late int classid;
  late String hours;
  late List<int> ids;
  late List<int> attendance;
  SaveAttendance(
      {required this.lectureId,
      required this.ids,
      required this.attendance,
      required this.classid,
      required this.hours});
}


