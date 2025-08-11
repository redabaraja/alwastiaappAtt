import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/getMyNotiBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyNotiBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyNotiBloc/repository.dart';
import 'package:alwastia/bloc/teacher/getMyNotiBloc/state.dart';

import 'package:alwastia/consts.dart';

class GetNotiBloc extends Bloc<GetNotisEvent, GetNotisState> {
  GetNotisRepo repo = GetNotisRepo();
  LocalData hive = LocalData();

  GetNotiBloc(super.initialState);
  @override
  GetNotisState get initialState => InitState();

  @override
  Stream<GetNotisState> mapEventToState(GetNotisEvent event) async* {
    if (event is GetMyNotis) {
      print('it should be loading now');
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        List<bool> isclicked = [];
        List<NotiModel> data =
            await repo.getNoti(token, event.classId.toString());
        for (var item in data) {
          isclicked.add(false);
        }
        yield MyNotis(data: data, connection: connection, Isclicked: isclicked);
      } else {
        yield MyNotis(data: [], connection: connection, Isclicked: []);
      }
    }
  }
}
