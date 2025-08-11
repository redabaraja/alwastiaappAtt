import 'package:equatable/equatable.dart';

class GetClassesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyClasses extends GetClassesEvent {
  late String status;
  GetMyClasses({required this.status});
}

