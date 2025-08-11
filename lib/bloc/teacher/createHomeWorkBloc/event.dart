import 'package:equatable/equatable.dart';

class CreateHomeWorkEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateHomeWork extends CreateHomeWorkEvent {
  late String name;
  late String desc;
  late String duedate;
  late int classId;
  CreateHomeWork(
      {required this.name,
      required this.desc,
      required this.classId,
      required this.duedate});
}
