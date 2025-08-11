import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/saveAttendanceBloc/event.dart';
import 'package:alwastia/bloc/teacher/saveAttendanceBloc/repository.dart';
import 'package:alwastia/bloc/teacher/saveAttendanceBloc/state.dart';

import 'package:alwastia/consts.dart';

class SaveAttendanceBloc
    extends Bloc<SaveAttendanceEvent, SaveAttendanceState> {
  LocalData hive = new LocalData();

  SaveAttendanceBloc(super.initialState);
  @override
  SaveAttendanceState get initialState => InitState();
  SaveAttendanceRepo repo = new SaveAttendanceRepo();
  @override
  Stream<SaveAttendanceState> mapEventToState(
      SaveAttendanceEvent event) async* {
    if (event is SaveAttendance) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        // await hive.openBox();
        // String token = await hive.getToken();
        // await hive.userBox.close();
        List<Map> attendance = [];
        for (var i = 0; i < event.ids.length; i++) {
          var item = {"stuId": event.ids[i], "att": event.attendance[i]};
          attendance.add(item);
        }
        bool res = await repo.save(
            attendance, event.lectureId, toke, event.classid, event.hours);
        yield SaveDone(connection: connection, res: res);
      } else {
        yield SaveDone(connection: connection, res: false);
      }
    } 
   
  }
}
