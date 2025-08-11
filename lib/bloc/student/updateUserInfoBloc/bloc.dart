import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/student/profileBloc/localdata.dart';
import 'package:alwastia/bloc/student/profileBloc/repository.dart';
import 'package:alwastia/bloc/student/updateUserInfoBloc/event.dart';
import 'package:alwastia/bloc/student/updateUserInfoBloc/repository.dart';
import 'package:alwastia/bloc/student/updateUserInfoBloc/state.dart';
import 'package:alwastia/consts.dart';

class UpdateUserInfoBloc
    extends Bloc<UpdateUserInfoEvent, UpdateUserInfoState> {
  UpdateUserInfoBloc(super.initialState);

  @override
  UpdateUserInfoState get initialState => InitState();
  UpdateUserRepo repo = UpdateUserRepo();
  ProfileRepo repo2 = ProfileRepo();
  LocalUserInfo hive1 = LocalUserInfo();
  LocalData hive2 = LocalData();

  @override
  Stream<UpdateUserInfoState> mapEventToState(
      UpdateUserInfoEvent event) async* {
    if (event is UpdateData) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive1.openBox();
        await hive2.openBox();
        print(event.phone);
        bool res = await repo.updateUserInfo(await hive2.getToken(), event.name,
            event.email, event.phone, event.city, event.address);
        print("we are here");
        if (res) {
          print("we are here yes yes");
          hive1.userinfoBox.clear();
          await repo2.getUserInfo(await hive2.getToken());
          yield UpdateState(connection: connection, res: res);
        } else {
          yield UpdateState(connection: connection, res: false);
        }
      } else {
        print("we are here no no");
        yield UpdateState(connection: connection, res: false);
      }
    }
  }
}
