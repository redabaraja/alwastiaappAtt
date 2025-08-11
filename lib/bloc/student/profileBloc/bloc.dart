import 'dart:io';

import 'package:alwastia/bloc/student/loginBloc/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/student/profileBloc/event.dart';
import 'package:alwastia/bloc/student/profileBloc/model.dart';
import 'package:alwastia/bloc/student/profileBloc/state.dart';
import 'package:alwastia/bloc/student/profileBloc/localdata.dart';
import 'package:alwastia/bloc/student/profileBloc/repository.dart';

class ProFileBloc extends Bloc<ProfileEvent, ProfileState> {
  LocalUserInfo hive = LocalUserInfo();
  LocalData hive2 = LocalData();
  ProfileRepo repo = new ProfileRepo();
  LoginRepo repo2 = LoginRepo();

  ProFileBloc(super.initialState);
  @override
  ProfileState get initialState => InitState();
  Future<File> getFile(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    return File(dir.path + "/" + filename);
  }

  Future<bool> checkFile(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    return File(dir.path + "/" + filename).exists();
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetUserInfo) {
      yield LoadingState();
      print('userinfo');

      await hive2.openBox();
      await hive.openBox();
      // print(await hive2.getToken());
      if (await hive.userinfoBox.isEmpty) {
        print("yesss");
        String username = await hive2.getUsername();
        String password = await hive2.getPassword();
        await hive2.userBox.close();
        String token = await repo2.auth2(username, password);
        await repo.getUserInfo(token);

        UserModel userinfo = await hive.getData();
        await hive.userinfoBox.close();
        bool fileExsit =
            await checkFile(userinfo.logo == null ? '' : userinfo.logo);
        print(userinfo.logo);
        yield UserInfo(
            file: await getFile(userinfo.logo == null ? '' : userinfo.logo),
            fileExist: fileExsit,
            data: userinfo);
      } else {
        print("nooooo");

        UserModel userinfo = await hive.getData();
        await hive.userinfoBox.close();
        // await hive2.userBox.close();
        bool fileExsit =
            await checkFile(userinfo.logo == null ? '' : userinfo.logo);
        yield UserInfo(
            file: await getFile(userinfo.logo == null ? '' : userinfo.logo),
            fileExist: fileExsit,
            data: userinfo);
      }
    } else if (event is GetImage) {
      await hive.openBox();
      await hive2.openBox();
      print("get image ");
      UserModel userinfo = await hive.getData();
      var pfile =
          await ImagePicker.platform.pickImage(source: ImageSource.gallery);

      if (pfile != null) {
        yield LoadingState2();
        bool res = await repo.uploadProfileImage(
            File(pfile.path), await hive2.getToken());
        if (res) {
          print('yes');
          try {
            File file =
                await getFile(userinfo.logo == null ? '' : userinfo.logo);
            file.delete();
            hive.userinfoBox.clear();
            await repo.getUserInfo(await hive2.getToken());
            await hive.userinfoBox.close();
            await hive2.userBox.close();
            yield GetProfileImage(imagePath: pfile.path);
          } catch (e) {
            print(e);
          }
        } else {
          print('no');
        }
      }
    }
  }
}
