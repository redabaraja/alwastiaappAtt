import 'package:alwastia/bloc/student/loginBloc/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/event.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/model.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/repository.dart';
import 'package:alwastia/bloc/teacher/getMyStudents.dart/state.dart';

import 'package:alwastia/consts.dart';

class GetClassStudentsBloc
    extends Bloc<GetStudentsEvent, GetClassStudentsState> {
  GetClassStudentsRepo repo = GetClassStudentsRepo();
  LocalData hive = LocalData();
  LoginRepo repo2 = LoginRepo();

  GetClassStudentsBloc(super.initialState);
  @override
  GetClassStudentsState get initialState => InitState();

  @override
  Stream<GetClassStudentsState> mapEventToState(GetStudentsEvent event) async* {
    if (event is GetMyStudents) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String username = await hive.getUsername();
        String password = await hive.getPassword();
        String token = await repo2.auth2(username, password);
        await hive.userBox.close();
        List<StudentModel> data =
            await repo.getStudents(token, event.classId.toString());
        yield MyStudents(data: data, connection: connection);
      } else {
        yield MyStudents(data: [], connection: connection);
      }
    }
  }
}
