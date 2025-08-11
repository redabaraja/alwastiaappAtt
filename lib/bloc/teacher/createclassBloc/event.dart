import 'package:equatable/equatable.dart';

class CreateClassEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateClass extends CreateClassEvent {
  late String name;
  late String descr;

  CreateClass({required this.name, required this.descr});
}

class UpdateClass extends CreateClassEvent {
  late String name;
  late String descr;
  late int id;

  UpdateClass({required this.name, required this.descr, required this.id});
}
