import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/getMyExamsBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyExamsBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyExamsBloc/repository.dart';
import 'package:alwastia/bloc/teacher/getMyExamsBloc/state.dart';

import 'package:alwastia/consts.dart';

class GetExamsBloc extends Bloc<GetExamEvent, GetExamState> {
  GetExamRepo repo = GetExamRepo();
  LocalData hive = LocalData();

  GetExamsBloc(super.initialState);
  @override
  GetExamState get initialState => InitState();

  @override
  Stream<GetExamState> mapEventToState(GetExamEvent event) async* {
    if (event is GetMyExam) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        print('this is user token $token');
        await hive.userBox.close();
        List<ExamModel> data1 =
            await repo.getExam(token, event.classId.toString());
        yield MyExams(data: data1, connection: connection);
      } else {
        yield MyExams(data: [], connection: connection);
      }
    }
  }
}
