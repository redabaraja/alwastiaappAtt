import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/gethomeworks/event.dart';
import 'package:alwastia/bloc/teacher/gethomeworks/model.dart';
import 'package:alwastia/bloc/teacher/gethomeworks/repository.dart';
import 'package:alwastia/bloc/teacher/gethomeworks/state.dart';

import 'package:alwastia/consts.dart';

class GetHomeWorkBloc extends Bloc<GetHomeWorkEvent, GetHomeWorkState> {
  GetHomeWorkRepo repo = GetHomeWorkRepo();
  LocalData hive = LocalData();

  GetHomeWorkBloc(super.initialState);
  @override
  GetHomeWorkState get initialState => InitState();

  @override
  Stream<GetHomeWorkState> mapEventToState(GetHomeWorkEvent event) async* {
    if (event is GetMyHomeWorks) {
      print('it should be loading now');
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        List<bool> isclicked = [];
        List<HomeWorkModel> data =
            await repo.getHomeWork(token, event.classId.toString());
        for (var item in data) {
          isclicked.add(false);
        }
        yield MyHomeWork(
            data: data, connection: connection, Isclicked: isclicked);
      } else {
        yield MyHomeWork(data: [], connection: connection, Isclicked: []);
      }
    }
  }
}
