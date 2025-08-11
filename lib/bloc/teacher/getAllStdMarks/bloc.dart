import 'package:alwastia/bloc/teacher/getAllStdMarks/event.dart';
import 'package:alwastia/bloc/teacher/getAllStdMarks/model.dart';
import 'package:alwastia/bloc/teacher/getAllStdMarks/repository.dart';
import 'package:alwastia/bloc/teacher/getAllStdMarks/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/consts.dart';

class GetAllStdMarksBloc
    extends Bloc<GetAllStdMarksEvent, GetAllStdMarksState> {
  GetAllStdMarksRepo repo = GetAllStdMarksRepo();
  // GetClassStudentsRepo repo2 = GetClassStudentsRepo();
  LocalData hive = LocalData();

  GetAllStdMarksBloc(super.initialState);
  @override
  GetAllStdMarksState get initialState => InitState();

  @override
  Stream<GetAllStdMarksState> mapEventToState(
      GetAllStdMarksEvent event) async* {
    if (event is GetAllStdMarks) {
      print('loadingState');
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        // await hive.openBox();
        // String token = await hive.getToken();
        // await hive.userBox.close();

        List<MarksModel> data =
            await repo.getMarks(toke, event.classId.toString());
        yield GetAllSTdMarksDone(data: data, connection: connection);
      } else {
        yield GetAllSTdMarksDone(data: [], connection: connection);
      }
    }
  }
}
