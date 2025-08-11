import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/repository.dart';
import 'package:alwastia/bloc/teacher/getMyLecturesBloc/state.dart';

import 'package:alwastia/consts.dart';

class GetLecturesBloc extends Bloc<GetLecturesEvent, GetLecturesState> {
  GetLecturesRepo repo = GetLecturesRepo();
  LocalData hive = LocalData();

  GetLecturesBloc(super.initialState);
  @override
  GetLecturesState get initialState => InitState();

  @override
  Stream<GetLecturesState> mapEventToState(GetLecturesEvent event) async* {
    if (event is GetMyLectures) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        List<LectureModel> data = [];
        List<LectureModel> data1 =
            await repo.getLectures(token, event.classId.toString(), '0');
        List<LectureModel> data2 =
            await repo.getLectures(token, event.classId.toString(), '-1');
        for (var i = 0; i < data1.length; i++) {
          data.add(data1[i]);
        }
        for (var i = 0; i < data2.length; i++) {
          data.add(data2[i]);
        }
        yield MyLectures(data: data, connection: connection);
      } else {
        yield MyLectures(data: [], connection: connection);
      }
    } else if (event is GetMyLecturesAsStd) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        List<LectureModel> data =
            await repo.getLectures(token, event.classId.toString(), '0');
        yield MyLectures(data: data, connection: connection);
      } else {
        yield MyLectures(data: [], connection: connection);
      }
    } else if (event is GetMyLectureswithNoLoading) {
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        List<LectureModel> data = [];
        List<LectureModel> data1 =
            await repo.getLectures(token, event.classId.toString(), '0');
        List<LectureModel> data2 =
            await repo.getLectures(token, event.classId.toString(), '-1');
        for (var i = 0; i < data1.length; i++) {
          data.add(data1[i]);
        }
        for (var i = 0; i < data2.length; i++) {
          data.add(data2[i]);
        }
        yield MyLectures(data: data, connection: connection);
      } else {
        yield MyLectures(data: [], connection: connection);
      }
    }
  }
}
