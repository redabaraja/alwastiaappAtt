import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/getMyClosingClassesBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyClosingClassesBloc/repository.dart';
import 'package:alwastia/bloc/teacher/getMyClosingClassesBloc/state.dart';
import 'package:alwastia/consts.dart';

class GetClosingClassesBloc
    extends Bloc<GetClosingClassesEvent, GetClassesState2> {
  GetClassesRepo repo = GetClassesRepo();
  LocalData hive = LocalData();

  GetClosingClassesBloc(super.initialState);
  @override
  GetClassesState2 get initialState => InitState();

  @override
  Stream<GetClassesState2> mapEventToState(GetClosingClassesEvent event) async* {
    if (event is GetMyClosingClasses) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        List<ClassModel> data = await repo.getClasses(token, event.status);
        yield MyClosingClasses(data: data, connection: connection);
      } else {
        yield MyClosingClasses(data: [], connection: connection);
      }
    }
  }
}
