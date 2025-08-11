import 'package:equatable/equatable.dart';

class GetStudentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyStudents extends GetStudentsEvent {
  late int classId;
  GetMyStudents({required this.classId});
}
