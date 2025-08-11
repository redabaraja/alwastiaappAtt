import 'package:alwastia/bloc/teacher/getMyExamsBloc/model.dart';

class GetExamState {}

class InitState extends GetExamState {}

class LoadingState2 extends GetExamState {}

class MyExams extends GetExamState {
  late bool connection;
  late List<ExamModel> data;
  MyExams({required this.data, required this.connection});
}
