import 'package:alwastia/bloc/student/loginBloc/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/bloc/student/geLinkedClassesBloc/event.dart';
import 'package:alwastia/bloc/student/geLinkedClassesBloc/repository.dart';
import 'package:alwastia/bloc/student/geLinkedClassesBloc/state.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/consts.dart';

class GetLinkedClassesBloc
    extends Bloc<GetLinkedClassesEvent, GetLinkedClassesState> {
  GetLinkedClassesRepo repo = GetLinkedClassesRepo();
  LocalData hive2 = LocalData();
  LoginRepo repo2 = LoginRepo();

  GetLinkedClassesBloc(super.initialState);
  @override
  GetLinkedClassesState get initialState => InitState();

  @override
  Stream<GetLinkedClassesState> mapEventToState(
      GetLinkedClassesEvent event) async* {
    if (event is GetLinkedClasses) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive2.openBox();
        String username = await hive2.getUsername();
        String password = await hive2.getPassword();
        String token = await repo2.auth2(username, password);
        toke = token;
        await hive2.userBox.close();
        List<ClassModel2> data = await repo.getLinkedClasses(token);
        yield MyLinkedClasses(data: data, connection: connection);
      } else {
        yield MyLinkedClasses(data: [], connection: connection);
      }
    }
  }
}
