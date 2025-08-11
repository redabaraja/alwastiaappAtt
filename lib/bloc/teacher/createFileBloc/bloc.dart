import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/createFileBloc/event.dart';
import 'package:alwastia/bloc/teacher/createFileBloc/repository.dart';
import 'package:alwastia/bloc/teacher/createFileBloc/state.dart';
import 'package:alwastia/consts.dart';

class CreateFileBloc extends Bloc<CreateFileEvent, CreateFileState> {
  LocalData hive = new LocalData();

  CreateFileBloc(super.initialState);
  @override
  CreateFileState get initialState => InitState();
  CreateFileRepo repo = new CreateFileRepo();
  Future<File> getFile(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    return File(dir.path + "/" + filename + ".png");
  }

  Future<bool> checkFile(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    return File(dir.path + "/" + filename + ".png").exists();
  }

  @override
  Stream<CreateFileState> mapEventToState(CreateFileEvent event) async* {
    if (event is CreateFile) {
      yield LoadingState();
      bool connection = await hasNetwork();
      print(event.lectureid);

      if (connection) {
        await hive.openBox();
        String token= await hive.getToken();
        bool res = await repo.uploadFile(event.file,token ,
            event.lectureid.toString(), event.title);
        await hive.userBox.close();
        yield CreateFileDone(connection: connection, res: res);
      } else {
        yield CreateFileDone(connection: connection, res: false);
      }
    } else if (event is GetFile) {
      var pfile = await FilePicker.platform.pickFiles();

      if (pfile != null) {
        int ext = getExtnumber(pfile.files.first.extension.toString());
        yield GetFileDone(
            filePath: pfile.files.first.path.toString(),
            name: pfile.files.first.name,
            ext: ext);
      }
    }
  }

  getExtnumber(String ext) {
    if (ext == 'png' ||
        ext == 'jpg' ||
        ext == 'jpeg' ||
        ext == 'gif' ||
        ext == 'bmp') {
      return 0;
    } else if (ext == 'pdf') {
      return 1;
    } else if (ext == 'doc' || ext == 'docx') {
      return 3;
    } else if (ext == 'ppt' || ext == 'pptx') {
      return 2;
    } else {
      return 4;
    }
  }
}
