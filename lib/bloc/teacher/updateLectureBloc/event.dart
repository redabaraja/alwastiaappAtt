import 'package:equatable/equatable.dart';

class UpdateLectureEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateLecture extends UpdateLectureEvent {
  late String name;
  late String descr;
  late int id;
  late int classid;
  UpdateLecture(
      {required this.name,
      required this.descr,
      required this.id,
      required this.classid});
}
