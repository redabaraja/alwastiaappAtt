import 'package:equatable/equatable.dart';

class GetAttendanceDatesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyAttendanceDates extends GetAttendanceDatesEvent {
  late int classId;
  GetMyAttendanceDates({required this.classId});
}

// class GetMyLecturesAsStd extends GetAttendanceDatesEvent {
//   late int classId;
//   GetMyLecturesAsStd({required this.classId});
// }

// class GetMyLectureswithNoLoading extends GetAttendanceDatesEvent {
//   late int classId;
//   GetMyLectureswithNoLoading({required this.classId});
// }
