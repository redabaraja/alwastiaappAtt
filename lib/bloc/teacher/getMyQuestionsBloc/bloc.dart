import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/getMyQuestionsBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyQuestionsBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyQuestionsBloc/repository.dart';
import 'package:alwastia/bloc/teacher/getMyQuestionsBloc/state.dart';

import 'package:alwastia/consts.dart';

class GetQuestionBloc extends Bloc<GetQuestionsEvent, GetQuestionsState> {
  GetQuestionRepo repo = GetQuestionRepo();
  LocalData hive = LocalData();

  GetQuestionBloc(super.initialState);
  @override
  GetQuestionsState get initialState => InitState();

  @override
  Stream<GetQuestionsState> mapEventToState(GetQuestionsEvent event) async* {
    if (event is GetMyQuestions) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        List<QuestionModel> data =
            await repo.getQuestions(token, event.lectreId.toString());
        yield MyQuestions(data: data, connection: connection);
      } else {
        yield MyQuestions(data: [], connection: connection);
      }
    }
  }
}
