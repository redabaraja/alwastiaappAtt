import 'package:equatable/equatable.dart';

class CreateNotiEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateNoti extends CreateNotiEvent {
  late String name;
  late int classId;
  late String detail;
  CreateNoti({required this.name, required this.classId,required this.detail});
}
