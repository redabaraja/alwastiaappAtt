import 'package:alwastia/bloc/student/loginBloc/repository.dart';
import 'package:alwastia/bloc/teacher/getAttendances/event.dart';
import 'package:alwastia/bloc/teacher/getAttendances/model.dart';
import 'package:alwastia/bloc/teacher/getAttendances/repository.dart';
import 'package:alwastia/bloc/teacher/getAttendances/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';

import 'package:alwastia/consts.dart';

class GetAttendanceDatesBloc
    extends Bloc<GetAttendanceDatesEvent, GetAttendanceDatesState> {
  GetAttendanceDatesRepo repo = GetAttendanceDatesRepo();
  LoginRepo repo2 = LoginRepo();
  LocalData hive = LocalData();

  GetAttendanceDatesBloc(super.initialState);
  @override
  GetAttendanceDatesState get initialState => InitState();

  @override
  Stream<GetAttendanceDatesState> mapEventToState(
      GetAttendanceDatesEvent event) async* {
    if (event is GetMyAttendanceDates) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        // await hive.openBox();
        // String username = await hive.getUsername();
        // String password = await hive.getPassword();
        // String token = await repo2.auth2(username, password);
        // await hive.userBox.close();
        List<AtendanceDatesModel> data =
            await repo.getLectures(toke, event.classId.toString());
        yield MyAttendanceDates(connection: connection, data: data);
      } else {
        yield MyAttendanceDates(connection: connection, data: []);
      }
    }
  }
}
