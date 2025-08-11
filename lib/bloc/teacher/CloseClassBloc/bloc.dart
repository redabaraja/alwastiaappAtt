import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/CloseClassBloc/event.dart';
import 'package:alwastia/bloc/teacher/CloseClassBloc/repository.dart';
import 'package:alwastia/bloc/teacher/CloseClassBloc/state.dart';

import 'package:alwastia/consts.dart';

class CloseClassBloc extends Bloc<CloseClassEvent, CloseClassState> {
  CloseClassRepo repo = CloseClassRepo();
  LocalData hive = LocalData();

  CloseClassBloc(super.initialState);
  @override
  CloseClassState get initialState => InitState();

  @override
  Stream<CloseClassState> mapEventToState(CloseClassEvent event) async* {
    if (event is CloseClass) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.closeCLass(token, event.classId.toString());
        yield CloseState(res: res, connection: connection);
      } else {
        yield CloseState(res: false, connection: connection);
      }
    } else if (event is ActivateClass) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.activateCLass(token, event.classId.toString());
        yield CloseState(res: res, connection: connection);
      } else {
        yield CloseState(res: false, connection: connection);
      }
    }
  }
}
