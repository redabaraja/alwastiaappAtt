import 'package:alwastia/bloc/teacher/getStudentsMarks/event.dart';
import 'package:alwastia/bloc/teacher/getStudentsMarks/model.dart';
import 'package:alwastia/bloc/teacher/getStudentsMarks/model2.dart';
import 'package:alwastia/bloc/teacher/getStudentsMarks/repository.dart';
import 'package:alwastia/bloc/teacher/getStudentsMarks/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/consts.dart';

class GetMarksBloc extends Bloc<GetMarksEvent, GetMarksState> {
  GetMarksRepo repo = GetMarksRepo();
  // GetClassStudentsRepo repo2 = GetClassStudentsRepo();
  LocalData hive = LocalData();

  GetMarksBloc(super.initialState);
  @override
  GetMarksState get initialState => InitState();

  @override
  Stream<GetMarksState> mapEventToState(GetMarksEvent event) async* {
    if (event is GetMarks) {
      print('loadingState');
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        // await hive.openBox();
        // String token = await hive.getToken();
        // await hive.userBox.close();

        ResultModel? data =
            await repo.getMarks(toke, event.semesterId.toString());
        yield GetMarksDone(data: data, connection: connection);
      } else {
        yield GetMarksDone(data: null, connection: connection);
      }
    }
  }
}
