import 'package:alwastia/bloc/teacher/getMyQuestionsBloc/model.dart';

class GetQuestionsState {}

class InitState extends GetQuestionsState {}

class LoadingState2 extends GetQuestionsState {}

class MyQuestions extends GetQuestionsState {
  late bool connection;
  late List<QuestionModel> data;
  MyQuestions({required this.data, required this.connection});
}
