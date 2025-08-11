import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/student/loginBloc/repository.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/repository.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/state.dart';
import 'package:alwastia/consts.dart';

class GetClassesBloc extends Bloc<GetClassesEvent, GetClassesState> {
  GetClassesRepo repo = GetClassesRepo();
  LoginRepo repo2 = LoginRepo();
  LocalData hive = LocalData();

  GetClassesBloc(super.initialState);
  @override
  GetClassesState get initialState => InitState();

  @override
  Stream<GetClassesState> mapEventToState(GetClassesEvent event) async* {
    if (event is GetMyClasses) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String username = await hive.getUsername();
        String password = await hive.getPassword();
        String token = await repo2.auth2(username, password);
        toke = token;
        await hive.userBox.close();
        List<ClassModel> data = await repo.getClasses2(token);
        yield MyClasses(data: data, connection: connection);
      } else {
        yield MyClasses(data: [], connection: connection);
      }
    }
  }
}
