import 'package:equatable/equatable.dart';

class GetHomeWorkEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyHomeWorks extends GetHomeWorkEvent {
  late int classId;
  GetMyHomeWorks({required this.classId});
}
