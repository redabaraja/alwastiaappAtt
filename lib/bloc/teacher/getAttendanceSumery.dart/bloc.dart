import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/event.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/model.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/repository.dart';
import 'package:alwastia/bloc/teacher/getAttendanceSumery.dart/state.dart';
import 'package:alwastia/consts.dart';

class AttendanceSummeryBloc
    extends Bloc<GetAttendanceSummeryEvent, AttendanceSummeryState> {
  GetClassAttendanceSummeryRepo repo = GetClassAttendanceSummeryRepo();
  LocalData hive = LocalData();

  AttendanceSummeryBloc(super.initialState);
  @override
  AttendanceSummeryState get initialState => InitState();

  @override
  Stream<AttendanceSummeryState> mapEventToState(
      GetAttendanceSummeryEvent event) async* {
    if (event is GetAttendanceSummery) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        // await hive.openBox();
        // String token = await hive.getToken();
        // await hive.userBox.close();
        List<AttendanceSummeryModel> data =
            await repo.getAttendanceSummery(toke, event.classId.toString());
        yield MyAttendanceSummery(data: data, connection: connection);
      } else {
        yield MyAttendanceSummery(data: [], connection: connection);
      }
    } else if (event is GetOneAttendanceSummery) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        // await hive.openBox();
        // String token = await hive.getToken();
        // await hive.userBox.close();
        List<AttendanceSummeryModel> data =
            await repo.getOneAttendanceSummery(toke, event.classId.toString());
        List<AttendancedetailsModel> data2 =
            await repo.getAttendanceDetails(toke, event.classId.toString());
        if (data.isNotEmpty) {
          yield MyOneAttendanceSummery(
              data: data[0], data2: data2, connection: connection);
        } else {
          yield MyOneAttendanceSummery(
              data: AttendanceSummeryModel(
                  exe: '',
                  id: 0,
                  name: '',
                  noexe: '',
                  result: '',
                  total: '',
                  userID: ''),
              data2: [],
              connection: connection);
        }
      } else {
        yield MyOneAttendanceSummery(
            data: AttendanceSummeryModel(
                exe: '',
                id: 0,
                name: '',
                noexe: '',
                result: '',
                total: '',
                userID: ''),
            data2: [],
            connection: connection);
      }
    }
    if (event is GetAttendanceDetails) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        // await hive.openBox();
        // String token = await hive.getToken();
        // await hive.userBox.close();
        List<AttendancedetailsModel> data =
            await repo.getAttendanceDetails(toke, event.classId.toString());
        yield MyOneAttendanceDetials(data: data, connection: connection);
      } else {
        yield MyOneAttendanceDetials(data: [], connection: connection);
      }
    }
  }
}
