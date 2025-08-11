import 'package:equatable/equatable.dart';

class GetAttendanceSummeryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAttendanceSummery extends GetAttendanceSummeryEvent {
  late int classId;
  GetAttendanceSummery({required this.classId});
}

class GetOneAttendanceSummery extends GetAttendanceSummeryEvent {
  late int classId;
  GetOneAttendanceSummery({required this.classId});
}

class GetAttendanceDetails extends GetAttendanceSummeryEvent {
  late int classId;
  GetAttendanceDetails({required this.classId});
}
