import 'package:equatable/equatable.dart';

class GetAllStdMarksEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAllStdMarks extends GetAllStdMarksEvent {
  late int classId;
  GetAllStdMarks({required this.classId});
}
