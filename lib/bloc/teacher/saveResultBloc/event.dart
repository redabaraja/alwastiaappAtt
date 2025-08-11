import 'package:alwastia/bloc/teacher/getAllStdMarks/model.dart';
import 'package:equatable/equatable.dart';

class SaveResultEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SaveResult extends SaveResultEvent {
  late List<MarksModel> data;
  late String classId;
  SaveResult({required this.data, required this.classId});
}
