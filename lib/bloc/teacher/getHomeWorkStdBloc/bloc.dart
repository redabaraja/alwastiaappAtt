import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/getHomeWorkStdBloc/event.dart';
import 'package:alwastia/bloc/teacher/getHomeWorkStdBloc/model.dart';
import 'package:alwastia/bloc/teacher/getHomeWorkStdBloc/repository.dart';
import 'package:alwastia/bloc/teacher/getHomeWorkStdBloc/state.dart';
import 'package:path/path.dart' as path;
import 'package:alwastia/consts.dart';

class GetHomeWorkStudentsBloc
    extends Bloc<GetHomeWorkStudentsEvent, GetHomeWorkStudentsState> {
  GetHomeWorkStudentsRepo repo = GetHomeWorkStudentsRepo();
  LocalData hive = LocalData();

  GetHomeWorkStudentsBloc(super.initialState);
  @override
  GetHomeWorkStudentsState get initialState => InitState();

  @override
  Stream<GetHomeWorkStudentsState> mapEventToState(
      GetHomeWorkStudentsEvent event) async* {
    if (event is GetMyHomeWorkStudents) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        List<HomeWorkStudentModel> data = await repo.getHomeWorkStudents(
            token, event.assignmentId.toString());
        List<bool> fileExsit = [];
        List<String> filePath = [];
        Directory dir = await getApplicationDocumentsDirectory();
        for (var item in data) {
          filePath.add(path.join(dir.path, item.fileName));
          File file = new File(path.join(dir.path, item.fileName));
          if (await file.exists()) {
            fileExsit.add(true);
          } else {
            fileExsit.add(false);
          }
        }
        yield MyHomeWorkStudents(
            data: data,
            connection: connection,
            fileExsit: fileExsit,
            filePath: filePath);
      } else {
        yield MyHomeWorkStudents(
            data: [], connection: connection, fileExsit: [], filePath: []);
      }
    }
  }
}
