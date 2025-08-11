import 'package:equatable/equatable.dart';

class UpdatePassCodeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatePassCode extends UpdatePassCodeEvent {
  late String passCode;
  late int classId;
  UpdatePassCode({required this.passCode, required this.classId});
}
