import 'package:equatable/equatable.dart';

class GetMarksEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMarks extends GetMarksEvent {
  late int semesterId;
  GetMarks({required this.semesterId});
}
