import 'package:alwastia/bloc/student/getStdSemesters/event.dart';
import 'package:alwastia/bloc/student/getStdSemesters/model.dart';
import 'package:alwastia/bloc/student/getStdSemesters/repository.dart';
import 'package:alwastia/bloc/student/getStdSemesters/state.dart';
import 'package:alwastia/bloc/student/loginBloc/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/consts.dart';

class GetStdSemestersBloc
    extends Bloc<GetStdSemestersEvent, GetStdSemestersState> {
  GetStdSemestersRepo repo = GetStdSemestersRepo();
  LocalData hive2 = LocalData();
  LoginRepo repo2 = LoginRepo();

  GetStdSemestersBloc(super.initialState);
  @override
  GetStdSemestersState get initialState => InitState();

  @override
  Stream<GetStdSemestersState> mapEventToState(
      GetStdSemestersEvent event) async* {
    if (event is GetStdSemesters) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive2.openBox();
        String username = await hive2.getUsername();
        String password = await hive2.getPassword();
        String token = await repo2.auth2(username, password);
        toke = token;
        await hive2.userBox.close();
        List<SemesterModel> data = await repo.getSemesters(token);
        yield MySemesters(data: data, connection: connection);
      } else {
        yield MySemesters(data: [], connection: connection);
      }
    }
  }
}
