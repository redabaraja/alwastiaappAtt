import 'package:equatable/equatable.dart';

class GetLecturesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyLectures extends GetLecturesEvent {
  late int classId;
  GetMyLectures({required this.classId});
}

class GetMyLecturesAsStd extends GetLecturesEvent {
  late int classId;
  GetMyLecturesAsStd({required this.classId});
}

class GetMyLectureswithNoLoading extends GetLecturesEvent {
  late int classId;
  GetMyLectureswithNoLoading({required this.classId});
}
