import 'package:equatable/equatable.dart';

class GetClosingClassesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyClosingClasses extends GetClosingClassesEvent {
  late String status;
  GetMyClosingClasses({required this.status});
}
