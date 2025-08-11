import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/createclassBloc/event.dart';
import 'package:alwastia/bloc/teacher/createclassBloc/repository.dart';
import 'package:alwastia/bloc/teacher/createclassBloc/state.dart';
import 'package:alwastia/consts.dart';

class CreateClassBloc extends Bloc<CreateClassEvent, CreateClassState> {
  LocalData hive = new LocalData();

  CreateClassBloc(super.initialState);
  @override
  CreateClassState get initialState => InitState();
  CreateClassRepo repo = new CreateClassRepo();
  @override
  Stream<CreateClassState> mapEventToState(CreateClassEvent event) async* {
    if (event is CreateClass) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.createClass(event.name, event.descr, token);
        yield CreateClassDone(connection: connection, res: res);
      } else {
        yield CreateClassDone(connection: connection, res: false);
      }
    } else if (event is UpdateClass) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.updateClass(
            event.name, event.descr, token, event.id.toString());
        yield CreateClassDone(connection: connection, res: res);
      } else {
        yield CreateClassDone(connection: connection, res: false);
      }
    }
  }
}
