import 'package:equatable/equatable.dart';

class GetQuestionsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyQuestions extends GetQuestionsEvent {
  late int lectreId;
  GetMyQuestions({required this.lectreId});
}
