import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/updateLectureBloc/event.dart';
import 'package:alwastia/bloc/teacher/updateLectureBloc/repository.dart';
import 'package:alwastia/bloc/teacher/updateLectureBloc/state.dart';
import 'package:alwastia/consts.dart';

class UpdateLectureBloc extends Bloc<UpdateLectureEvent, UpdateLectureState> {
  LocalData hive = new LocalData();

  UpdateLectureBloc(super.initialState);
  @override
  UpdateLectureState get initialState => InitState();
  UpdateLectureRepo repo = new UpdateLectureRepo();
  @override
  Stream<UpdateLectureState> mapEventToState(UpdateLectureEvent event) async* {
    if (event is UpdateLecture) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.updatelecture(event.name, event.descr, token,
            event.id.toString(), event.classid.toString());
        yield UpdateLectureDone(connection: connection, res: res);
      } else {
        yield UpdateLectureDone(connection: connection, res: false);
      }
    }
  }
}
