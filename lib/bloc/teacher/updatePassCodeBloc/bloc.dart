import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/updatePassCodeBloc/event.dart';
import 'package:alwastia/bloc/teacher/updatePassCodeBloc/repository.dart';
import 'package:alwastia/bloc/teacher/updatePassCodeBloc/state.dart';
import 'package:alwastia/consts.dart';

class UpdatePasscodeBloc
    extends Bloc<UpdatePassCodeEvent, UpdatePassCodeState> {
  LocalData hive = new LocalData();

  UpdatePasscodeBloc(super.initialState);
  @override
  UpdatePassCodeState get initialState => InitState();
  UpdatePassCodeRepo repo = new UpdatePassCodeRepo();
  @override
  Stream<UpdatePassCodeState> mapEventToState(
      UpdatePassCodeEvent event) async* {
    if (event is UpdatePassCode) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.updatePasscode(
            token, event.classId.toString(), event.passCode);
        yield UpdatePassCodeDone(connection: connection, res: res);
      } else {
        yield UpdatePassCodeDone(connection: connection, res: false);
      }
    }
  }
}
