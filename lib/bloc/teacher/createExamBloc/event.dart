import 'package:equatable/equatable.dart';

class CreateExamEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateExam extends CreateExamEvent {
  late String name;
  late String max;
  late int classId;
  CreateExam(
      {required this.name, required this.classId, required this.max});
}
