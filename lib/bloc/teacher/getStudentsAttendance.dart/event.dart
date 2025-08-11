import 'package:equatable/equatable.dart';

class GetStudentsAttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyStudentsAttendance extends GetStudentsAttendanceEvent {
  late String lectureId;
  late int classId;
  late bool isnew;
  GetMyStudentsAttendance(
      {required this.lectureId, required this.classId, required this.isnew});
}
class Search extends GetStudentsAttendanceEvent {
  late String token;
  late List<String> names;
  late List<String> pids;
  late List<bool> checkStatus;
  Search(
      {required this.token,
      required this.names,
      required this.pids,
      required this.checkStatus});
}
