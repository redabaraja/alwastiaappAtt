import 'dart:io';

import 'package:equatable/equatable.dart';

class CreateFileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateFile extends CreateFileEvent {
  late String title;
  late File file ;
  late int lectureid;
  CreateFile(
      {required this.title, required this.file, required this.lectureid});
}
class GetFile extends CreateFileEvent {
}
