import 'package:equatable/equatable.dart';

class CloseLectureEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CloseLecture extends CloseLectureEvent {
  late int classId;
  CloseLecture({required this.classId});
}

class ActivateLecture extends CloseLectureEvent {
  late int classId;
  ActivateLecture({required this.classId});
}
