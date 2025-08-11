import 'package:equatable/equatable.dart';

class GetNotisEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyNotis extends GetNotisEvent {
  late int classId;
  GetMyNotis({required this.classId});
}
