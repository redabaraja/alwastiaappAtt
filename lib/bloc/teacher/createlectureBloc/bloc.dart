import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/createlectureBloc/event.dart';
import 'package:alwastia/bloc/teacher/createlectureBloc/repository.dart';
import 'package:alwastia/bloc/teacher/createlectureBloc/state.dart';
import 'package:alwastia/consts.dart';

class CreateLectureBloc extends Bloc<CreateLectureEvent, CreateLectureState> {
  LocalData hive = new LocalData();

  CreateLectureBloc(super.initialState);
  @override
  CreateLectureState get initialState => InitState();
  CreateCLectureRepo repo = new CreateCLectureRepo();
  @override
  Stream<CreateLectureState> mapEventToState(CreateLectureEvent event) async* {
    if (event is CreateLecture) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        bool res = await repo.createLecture(
            event.name, token, event.classId.toString(), event.desc);
        yield CreateLectureDone(connection: connection, res: res);
      } else {
        yield CreateLectureDone(connection: connection, res: false);
      }
    }
  }
}
