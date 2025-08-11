import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/CloseStudentInClass/event.dart';
import 'package:alwastia/bloc/teacher/CloseStudentInClass/repository.dart';
import 'package:alwastia/bloc/teacher/CloseStudentInClass/state.dart';

import 'package:alwastia/consts.dart';

class CloseStdBloc extends Bloc<CloseStdEvent, CloseStdState> {
  CloseStdRepo repo = CloseStdRepo();
  LocalData hive = LocalData();

  CloseStdBloc(super.initialState);
  @override
  CloseStdState get initialState => InitState();

  @override
  Stream<CloseStdState> mapEventToState(CloseStdEvent event) async* {
    if (event is CloseStd) {
      yield LoadingState3();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.closeStd(token, event.stdId.toString());
        yield CloseState(res: res, connection: connection);
      } else {
        yield CloseState(res: false, connection: connection);
      }
    } else if (event is ActivateStd) {
      yield LoadingState3();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.activateStd(token, event.stdId.toString());
        yield CloseState(res: res, connection: connection);
      } else {
        yield CloseState(res: false, connection: connection);
      }
    }
  }
}
