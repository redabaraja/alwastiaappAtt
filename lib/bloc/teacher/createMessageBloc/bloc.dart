import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/createMessageBloc/event.dart';
import 'package:alwastia/bloc/teacher/createMessageBloc/repository.dart';
import 'package:alwastia/bloc/teacher/createMessageBloc/state.dart';
import 'package:alwastia/consts.dart';

class CreateNotiBloc extends Bloc<CreateNotiEvent, CreateNotiState> {
  LocalData hive = new LocalData();

  CreateNotiBloc(super.initialState);
  @override
  CreateNotiState get initialState => InitState();
  CreateNotiRepo repo = new CreateNotiRepo();
  @override
  Stream<CreateNotiState> mapEventToState(CreateNotiEvent event) async* {
    if (event is CreateNoti) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.createNoti(
            event.name, token, event.classId.toString(), event.detail);
        yield CreateNotiDone(connection: connection, res: res);
      } else {
        yield CreateNotiDone(connection: connection, res: false);
      }
    }
  }
}
