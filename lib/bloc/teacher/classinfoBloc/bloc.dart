import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/classInfoBloc/event.dart';
import 'package:alwastia/bloc/teacher/classInfoBloc/repository.dart';
import 'package:alwastia/bloc/teacher/classInfoBloc/state.dart';

class ClassInfoBloc extends Bloc<ClassInfoEvent, CLassInfoState> {
  LocalData hive2 = LocalData();
  ClassInfoRepo repo = new ClassInfoRepo();

  ClassInfoBloc(super.initialState);
  @override
  CLassInfoState get initialState => InitState();
  // Future<File> getFile(String filename) async {
  //   Directory dir = await getApplicationDocumentsDirectory();
  //   return File(dir.path + "/" + filename + ".png");
  // }

  // Future<bool> checkFile(String filename) async {
  //   Directory dir = await getApplicationDocumentsDirectory();
  //   return File(dir.path + "/" + filename + ".png").exists();
  // }

  @override
  Stream<CLassInfoState> mapEventToState(ClassInfoEvent event) async* {
    if (event is GetImage) {
      print("get image ");
      var pfile = await ImagePicker.platform
          .getImageFromSource(source: ImageSource.gallery);
      if (pfile != null) {
        yield LoadingState();
        bool res = await repo.uploadClassImage(
            File(pfile.path), '', event.id.toString());
        if (res) {
          yield GetClassImage(imagePath: pfile.path);
        } else {
          print('no');
        }
      }
    }
  }
}
