import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/StudentAttendanceBloc/event.dart';
import 'package:alwastia/bloc/teacher/StudentAttendanceBloc/model.dart';
import 'package:alwastia/bloc/teacher/StudentAttendanceBloc/repository.dart';
import 'package:alwastia/bloc/teacher/StudentAttendanceBloc/state.dart';
import 'package:alwastia/consts.dart';

class OneStudentAttendanceBloc
    extends Bloc<GetOneStudentAttendanceEvent, OneStudentAttendanceState> {
  OneStudentAttendanceRepo repo = OneStudentAttendanceRepo();
  LocalData hive = LocalData();

  OneStudentAttendanceBloc(super.initialState);
  @override
  OneStudentAttendanceState get initialState => InitState();

  @override
  Stream<OneStudentAttendanceState> mapEventToState(
      GetOneStudentAttendanceEvent event) async* {
    if (event is GetOneStudentAttendance) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        List<OneStudentAttendanceModel> data =
            await repo.getAttendanceSummery(token, event.classId.toString());
        yield MyOneStudentAttendance(data: data, connection: connection);
      } else {
        yield MyOneStudentAttendance(data: [], connection: connection);
      }
    }
  }
}
