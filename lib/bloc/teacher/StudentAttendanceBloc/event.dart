import 'package:equatable/equatable.dart';

class GetOneStudentAttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetOneStudentAttendance extends GetOneStudentAttendanceEvent {
  late int classId;
  GetOneStudentAttendance({required this.classId});
}
