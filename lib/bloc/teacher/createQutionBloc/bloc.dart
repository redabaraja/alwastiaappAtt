import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/createQutionBloc/event.dart';
import 'package:alwastia/bloc/teacher/createQutionBloc/repository.dart';
import 'package:alwastia/bloc/teacher/createQutionBloc/state.dart';
import 'package:alwastia/consts.dart';

class CreateQuestionBloc extends Bloc<CreateQutionEvent, CreateQuestionState> {
  LocalData hive = new LocalData();

  CreateQuestionBloc(super.initialState);
  @override
  CreateQuestionState get initialState => InitState();
  CreateQutionRepo repo = new CreateQutionRepo();
  @override
  Stream<CreateQuestionState> mapEventToState(CreateQutionEvent event) async* {
    if (event is CreateQuestion) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.createQuestion(
            event.qution, event.answer, event.lectureId.toString(), token);
        yield CreateQuestionDone(connection: connection, res: res);
      } else {
        yield CreateQuestionDone(connection: connection, res: false);
      }
    }
  }
}
