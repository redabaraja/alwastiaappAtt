import 'package:equatable/equatable.dart';

class CreateLectureEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateLecture extends CreateLectureEvent {
  late String name;
  late String desc;
  late int classId;
  CreateLecture(
      {required this.name, required this.classId, required this.desc});
}
