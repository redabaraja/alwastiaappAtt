import 'package:equatable/equatable.dart';

class CloseClassEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CloseClass extends CloseClassEvent {
  late int classId;
  CloseClass({required this.classId});
}

class ActivateClass extends CloseClassEvent {
  late int classId;
  ActivateClass({required this.classId});
}
