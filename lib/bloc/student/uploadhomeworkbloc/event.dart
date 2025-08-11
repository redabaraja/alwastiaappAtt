import 'dart:io';

import 'package:equatable/equatable.dart';

class UploadHomeWorkEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UploadHomeWork extends UploadHomeWorkEvent {
  late File file;
  late int assignmentId;
  UploadHomeWork({required this.file, required this.assignmentId});
}

class GetFileForUpload extends UploadHomeWorkEvent {
  late int assignment;
  late int index;
  GetFileForUpload({required this.assignment, required this.index});
}

