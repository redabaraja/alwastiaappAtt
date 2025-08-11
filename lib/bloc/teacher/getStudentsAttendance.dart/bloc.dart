import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/event.dart';
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/model.dart';
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/repository.dart';
import 'package:alwastia/bloc/teacher/getStudentsAttendance.dart/state.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/repository.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/model.dart';

import 'package:alwastia/consts.dart';

class GetClassStudentsAttendanceBloc
    extends Bloc<GetStudentsAttendanceEvent, GetClassStudentsAttendanceState> {
  GetClassStudentsAttendanceRepo repo = GetClassStudentsAttendanceRepo();
  GetClassStudentsRepo repo2 = GetClassStudentsRepo();
  LocalData hive = LocalData();

  GetClassStudentsAttendanceBloc(super.initialState);
  @override
  GetClassStudentsAttendanceState get initialState => InitState();

  @override
  Stream<GetClassStudentsAttendanceState> mapEventToState(
      GetStudentsAttendanceEvent event) async* {
    if (event is GetMyStudentsAttendance) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        // await hive.openBox();
        // String token = await hive.getToken();
        // await hive.userBox.close();
        if (event.isnew) {
          List<StudentModel> data =
              await repo2.getStudents(toke, event.classId.toString());
          yield MyNewStudentsAttendance(data: data, connection: connection);
        } else {
          print('/n/n ${event.lectureId}\n\n');
          List<StudentAttendanceModel> data = await repo.getStudentsAttendance(
              toke, event.lectureId, event.classId.toString());
          yield MyStudentsAttendance(data: data, connection: connection);
        }
      } else {
        yield MyStudentsAttendance(data: [], connection: connection);
      }
    } 
    else if (event is Search) {
      List<String> names = [];
      List<String> pids = [];
      List<bool> checkStatus = [];
      List<int> indexs = [];
      print('we are here in search bloc');
      if (event.token == '' || event.token == ' ') {
        print('it is empty');
        for (int i = 0; i < event.names.length; i++) {
          indexs.add(i);
        }
        yield SearchDone(
            names: event.names,
            pids: event.pids,
            checkStatus: event.checkStatus,
            indexs: indexs);
      } else {
        print('we will search');
        for (var i = 0; i < event.names.length; i++) {
          if (event.names[i].contains(event.token)) {
            names.add(event.names[i]);
            pids.add(event.pids[i]);
            checkStatus.add(event.checkStatus[i]);
            indexs.add(i);
          }
        }
        yield SearchDone(
            names: names, pids: pids, checkStatus: checkStatus, indexs: indexs);
      }
    }
  
  }
}
