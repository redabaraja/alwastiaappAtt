import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/student/uploadhomeworkbloc/event.dart';
import 'package:alwastia/bloc/student/uploadhomeworkbloc/repository.dart';
import 'package:alwastia/bloc/student/uploadhomeworkbloc/state.dart';
import 'package:alwastia/consts.dart';

class UploadHomeWorkBloc
    extends Bloc<UploadHomeWorkEvent, UploadHomeWorkState> {
  LocalData hive = new LocalData();

  UploadHomeWorkBloc(super.initialState);
  @override
  UploadHomeWorkState get initialState => InitState();
  UploadHomeWorkRepo repo = new UploadHomeWorkRepo();
  Future<File> getFile(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    return File(dir.path + "/" + filename + ".png");
  }

  Future<bool> checkFile(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    return File(dir.path + "/" + filename + ".png").exists();
  }

  @override
  Stream<UploadHomeWorkState> mapEventToState(
      UploadHomeWorkEvent event) async* {
    if (event is UploadHomeWork) {
      yield LoadingState3();
      bool connection = await hasNetwork();
      print(event.assignmentId);

      if (connection) {
        await hive.openBox();
        String token = await hive.getToken();
        bool res = await repo.uploadFile(
            event.file, token, event.assignmentId.toString());
        await hive.userBox.close();
        yield UploadHomeWorkDone(connection: connection, res: res);
      } else {
        yield UploadHomeWorkDone(connection: connection, res: false);
      }
    } else if (event is GetFileForUpload) {
      var pfile = await FilePicker.platform.pickFiles();

      if (pfile != null) {
        int ext = getExtnumber(pfile.files.first.extension.toString());
        print(pfile.files.first.path.toString());
        yield GetFileDone(
            filePath: pfile.files.first.path.toString(),
            name: pfile.files.first.name,
            ext: ext,
            assignment: event.assignment,
            index: event.index);
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
