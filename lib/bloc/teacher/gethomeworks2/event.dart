import 'package:equatable/equatable.dart';

class GetHomeWorkEvent2 extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyHomeWorks2 extends GetHomeWorkEvent2 {
  late int classId;
  GetMyHomeWorks2({required this.classId});
}
