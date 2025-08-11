import 'package:equatable/equatable.dart';

class GetHomeWorkStudentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyHomeWorkStudents extends GetHomeWorkStudentsEvent {
  late int assignmentId;
  GetMyHomeWorkStudents({required this.assignmentId});
}
