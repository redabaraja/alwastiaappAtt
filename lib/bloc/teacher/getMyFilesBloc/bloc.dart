import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/event.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/model.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/repository.dart';
import 'package:alwastia/bloc/teacher/getMyFilesBloc/state.dart';
import 'package:path/path.dart' as path;

import 'package:alwastia/consts.dart';

class GetFilesBloc extends Bloc<GetFilesEvent, GetFilesState> {
  GetFilesRepo repo = GetFilesRepo();
  LocalData hive = LocalData();

  GetFilesBloc(super.initialState);
  @override
  GetFilesState get initialState => InitState();

  @override
  Stream<GetFilesState> mapEventToState(GetFilesEvent event) async* {
    if (event is GetMyFiles) {
      yield LoadingState2();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        await hive.userBox.close();
        List<FileModel> data =
            await repo.getFiles(token, event.lectureid.toString());
        List<bool> fileExsit = [];
        List<String> filePath = [];
        Directory dir = await getApplicationDocumentsDirectory();
        for (var item in data) {
          filePath.add(path.join(dir.path, item.fileName));
          File file = new File(path.join(dir.path, item.fileName));
          if (await file.exists()) {
            fileExsit.add(true);
          } else {
            fileExsit.add(false);
          }
        }
        print(fileExsit);
        print(filePath);
        yield MyFiles(
            data: data,
            connection: connection,
            fileExsit: fileExsit,
            filePath: filePath);
      } else {
        yield MyFiles(
            data: [], connection: connection, fileExsit: [], filePath: []);
      }
    }
  }

  deletedot(String ext) {
    String ex = '';
    for (var i = 0; i < ext.length; i++) {
      if (ext[i] != '.') {
        ex += ext[i];
      }
    }
    return ex;
  }
}
