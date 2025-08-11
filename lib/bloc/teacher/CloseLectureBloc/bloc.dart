import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/CloseLectureBloc/event.dart';
import 'package:alwastia/bloc/teacher/CloseLectureBloc/repository.dart';
import 'package:alwastia/bloc/teacher/CloseLectureBloc/state.dart';

import 'package:alwastia/consts.dart';

class CloseLectureBloc extends Bloc<CloseLectureEvent, CloseLectureState> {
  CloseLectureRepo repo = CloseLectureRepo();
  LocalData hive = LocalData();

  CloseLectureBloc(super.initialState);
  @override
  CloseLectureState get initialState => InitState();

  @override
  Stream<CloseLectureState> mapEventToState(CloseLectureEvent event) async* {
    if (event is CloseLecture) {
      yield LoadingState3();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.closeLecture(token, event.classId.toString());
        yield CloseState(res: res, connection: connection);
      } else {
        yield CloseState(res: false, connection: connection);
      }
    } else if (event is ActivateLecture) {
      yield LoadingState3();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.activateLecture(token, event.classId.toString());
        yield CloseState(res: res, connection: connection);
      } else {
        yield CloseState(res: false, connection: connection);
      }
    }
  }
}
