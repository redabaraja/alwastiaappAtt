import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/gethomeworks2/event.dart';
import 'package:alwastia/bloc/teacher/gethomeworks2/model.dart';
import 'package:alwastia/bloc/teacher/gethomeworks2/repository.dart';
import 'package:alwastia/bloc/teacher/gethomeworks2/state.dart';

import 'package:alwastia/consts.dart';

class GetHomeWorkBloc2 extends Bloc<GetHomeWorkEvent2, GetHomeWorkState2> {
  GetHomeWorkRepo2 repo = GetHomeWorkRepo2();
  LocalData hive = LocalData();

  GetHomeWorkBloc2(super.initialState);
  @override
  GetHomeWorkState2 get initialState => InitState();

  @override
  Stream<GetHomeWorkState2> mapEventToState(GetHomeWorkEvent2 event) async* {
    if (event is GetMyHomeWorks2) {
      print('it should be loading now');
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        List<bool> isclicked = [];
        List<HomeWorkModel2> data =
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
