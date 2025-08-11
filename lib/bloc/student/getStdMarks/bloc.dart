import 'package:alwastia/bloc/student/getStdMarks/event.dart';
import 'package:alwastia/bloc/student/getStdMarks/model.dart';
import 'package:alwastia/bloc/student/getStdMarks/repository.dart';
import 'package:alwastia/bloc/student/getStdMarks/state.dart';
import 'package:alwastia/bloc/student/loginBloc/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/consts.dart';

class GetStdMarksBloc extends Bloc<GetMarksEvent, GetStdMarksState> {
  GetMarksRepo repo = GetMarksRepo();
  LocalData hive2 = LocalData();

  // GetClassStudentsRepo repo2 = GetClassStudentsRepo();
  LocalData hive = LocalData();
  LoginRepo repo2 = LoginRepo();

  GetStdMarksBloc(super.initialState);
  @override
  GetStdMarksState get initialState => InitState();

  @override
  Stream<GetStdMarksState> mapEventToState(GetMarksEvent event) async* {
    if (event is GetMarks) {
      print('loadingState');
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive2.openBox();
        String username = await hive2.getUsername();
        String password = await hive2.getPassword();
        String token = await repo2.auth2(username, password);
        toke = token;
        await hive2.userBox.close();
        // await hive.openBox();
        // String token = await hive.getToken();
        // await hive.userBox.close();

        List<MarksModelMain> data = await repo.getMarks(toke);

        yield GetMarksDone(data: data, connection: connection);
      } else {
        yield GetMarksDone(data: [], connection: connection);
      }
    }
  }
}
