import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/LinkClassBloc/event.dart';
import 'package:alwastia/bloc/student/LinkClassBloc/repository.dart';
import 'package:alwastia/bloc/student/LinkClassBloc/state.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';

class LinkClassBloc extends Bloc<LinkCLassEvent, LinkClassState> {
  LinkClassesRepo repo = LinkClassesRepo();

  LinkClassBloc(super.initialState);
  @override
  LinkClassState get initialState => InitState();
  LocalData hive = LocalData();

  @override
  Stream<LinkClassState> mapEventToState(LinkCLassEvent event) async* {
    if (event is LinkClass) {
      yield LoadingStateForLinking();
      print('this is the classId : ${event.ky}');
      await hive.openBox();
      String token = await hive.getToken();
      await hive.userBox.close();
      bool res = await repo.linkClass(event.ky, token, event.passcode);
      yield LinkClassDone(connection: true, res: res);
    }
  }
}
