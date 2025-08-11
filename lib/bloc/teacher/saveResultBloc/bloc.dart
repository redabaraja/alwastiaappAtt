import 'package:alwastia/bloc/teacher/getAllStdMarks/model.dart';
import 'package:alwastia/bloc/teacher/saveResultBloc/event.dart';
import 'package:alwastia/bloc/teacher/saveResultBloc/repository.dart';
import 'package:alwastia/bloc/teacher/saveResultBloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';

import 'package:alwastia/consts.dart';

class SaveResultBloc extends Bloc<SaveResultEvent, SaveResultState> {
  LocalData hive = new LocalData();

  SaveResultBloc(super.initialState);
  @override
  SaveResultState get initialState => InitState();
  SaveResultRepo repo = new SaveResultRepo();
  @override
  Stream<SaveResultState> mapEventToState(SaveResultEvent event) async* {
    if (event is SaveResult) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        // await hive.openBox();
        // String token = await hive.getToken();
        // await hive.userBox.close();
        List<Map> results = [];
        for (var i = 0; i < event.data.length; i++) {
          results.add(MarksModel.toJson(event.data[i]));
        }
        bool res = await repo.save(results, toke, event.classId);
        yield SaveDone(connection: connection, res: res);
      } else {
        yield SaveDone(connection: connection, res: false);
      }
    }
  }
}
