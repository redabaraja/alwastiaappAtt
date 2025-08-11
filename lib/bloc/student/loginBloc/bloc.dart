import 'package:alwastia/bloc/student/profileBloc/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/event.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/student/loginBloc/repository.dart';
import 'package:alwastia/bloc/student/loginBloc/state.dart';
import 'package:alwastia/consts.dart';
import 'package:alwastia/bloc/student/profileBloc/localdata.dart';
import 'package:alwastia/bloc/student/profileBloc/repository.dart';
import 'dart:io';
// import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepo rep = new LoginRepo();
  LocalData hive = new LocalData();
  LocalUserInfo hive2 = LocalUserInfo();
  ProfileRepo repo = new ProfileRepo();

  LoginBloc(super.initialState);
  @override
  LoginState get initialState => InitState();
  Future<File> getFile(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    return File(dir.path + "/" + filename);
  }

  Future<bool> checkFile(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    return File(dir.path + "/" + filename).exists();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Loginn) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        print(
            'this the username ${event.username}   ,,,  this the password ${event.password}');
        String token = await rep.auth2(event.username, event.password);
        if (token.isNotEmpty) {
          await hive2.openBox();
          await hive.openBox();
          // await hive.addToken(data[1]);
          await hive.addId(event.username);

          await hive.addUsername(event.username);
          await hive.addPassword(event.password);

          await repo.getUserInfo(token);
          UserModel userinfo = await hive2.getData();
          await hive.addType(userinfo.role);
          await hive.userBox.close();
          await hive2.userinfoBox.close();
          yield Logined(
              connection: connection,
              res: true,
              type: userinfo.role == 'الطلاب' ? 2 : 1);
        } else {
          yield Logined(connection: connection, res: false, type: 1);
        }
      } else {
        yield Logined(connection: connection, res: false, type: 1);
      }
    } else if (event is UpdatePassWord) {
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        await hive.openBox();
        String username = await hive.getUsername();
        String password = await hive.getPassword();
        String token = await rep.auth2(username, password);
        List data = await rep.updatePassWord(
            token, event.oldPassword, event.newPassword);
        if (data[0] == 1) {
          // await hive.openBox();
          String username = await hive.getUsername();
          String type = await hive.getType();
          await hive.userBox.clear();
          await hive.addUsername(username);
          await hive.addPassword(event.newPassword);
          await hive.addType(type);
        }
        await hive.userBox.close();
        yield UpdatePassWordDone(res: data[0] == 1, txt: data[1]);
      } else {
        yield UpdatePassWordDone(res: false, txt: '');
      }
    }
  }
}
