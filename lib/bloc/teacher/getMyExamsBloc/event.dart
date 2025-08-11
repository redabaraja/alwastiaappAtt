import 'package:equatable/equatable.dart';

class GetExamEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyExam extends GetExamEvent {
  late int classId;
  GetMyExam({required this.classId});
}
