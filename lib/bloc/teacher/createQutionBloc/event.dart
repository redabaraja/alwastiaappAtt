import 'package:equatable/equatable.dart';

class CreateQutionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateQuestion extends CreateQutionEvent {
  late String qution;
  late String answer;
  late int lectureId;
  CreateQuestion(
      {required this.qution, required this.answer, required this.lectureId});
}
