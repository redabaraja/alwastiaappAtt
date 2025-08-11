import 'package:equatable/equatable.dart';

class GetFilesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyFiles extends GetFilesEvent {
  late int lectureid;
  GetMyFiles({required this.lectureid});
}
