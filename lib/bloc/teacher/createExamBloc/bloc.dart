import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/createExamBloc/event.dart';
import 'package:alwastia/bloc/teacher/createExamBloc/repository.dart';
import 'package:alwastia/bloc/teacher/createExamBloc/state.dart';
import 'package:alwastia/consts.dart';

class CreateExamBloc extends Bloc<CreateExamEvent, CreateExamState> {
  LocalData hive = new LocalData();

  CreateExamBloc(super.initialState);
  @override
  CreateExamState get initialState => InitState();
  CreateCExamRepo repo = new CreateCExamRepo();
  @override
  Stream<CreateExamState> mapEventToState(CreateExamEvent event) async* {
    if (event is CreateExam) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.createExam(
            event.name, token, event.classId.toString(), event.max);
        yield CreateExamDone(connection: connection, res: res);
      } else {
        yield CreateExamDone(connection: connection, res: false);
      }
    }
  }
}
