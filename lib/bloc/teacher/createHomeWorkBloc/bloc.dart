import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/createHomeWorkBloc/event.dart';
import 'package:alwastia/bloc/teacher/createHomeWorkBloc/repository.dart';
import 'package:alwastia/bloc/teacher/createHomeWorkBloc/state.dart';
import 'package:alwastia/consts.dart';

class CreateHomeWorkBloc
    extends Bloc<CreateHomeWorkEvent, CreateHomeWorkState> {
  LocalData hive = new LocalData();

  CreateHomeWorkBloc(super.initialState);
  @override
  CreateHomeWorkState get initialState => InitState();
  CreateHomeWorkRepo repo = new CreateHomeWorkRepo();
  @override
  Stream<CreateHomeWorkState> mapEventToState(
      CreateHomeWorkEvent event) async* {
    if (event is CreateHomeWork) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        print('date is ${event.duedate}');
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.createHomeWork(event.name, event.desc,
            event.classId.toString(), event.duedate, token);
        yield CreateHomeWorkDone(connection: connection, res: res);
      } else {
        yield CreateHomeWorkDone(connection: connection, res: false);
      }
    }
  }
}
