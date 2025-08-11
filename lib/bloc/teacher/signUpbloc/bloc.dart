import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/bloc/teacher/signUpbloc/event.dart';
import 'package:alwastia/bloc/teacher/signUpbloc/repository.dart';
import 'package:alwastia/bloc/teacher/signUpbloc/state.dart';
import 'package:alwastia/consts.dart';

class TSignUpBloc extends Bloc<SignUpEvent, TSignUpState> {
  SignUpRepo rep = new SignUpRepo();
  LocalData hive = new LocalData();

  TSignUpBloc(super.initialState);
  @override
  TSignUpState get initialState => InitState();

  @override
  Stream<TSignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is Signing) {
      yield LoadingState();
      String uname = '';
      for (var i = 0; i < event.username.length; i++) {
        if (event.username[i] != "@") {
          uname += event.username[i];
        } else {
          break;
        }
      }
    
      bool connection = await hasNetwork();
      if (connection) {
        bool code = await rep.signUp(uname, event.password,
            event.number, event.address, event.name, event.username);
        if (code) {
          List data = await rep.auth(event.username, event.password);
          if (data.isNotEmpty) {
            print(data[0]);
            print(data[1]);
            if (data[0]) {
              await hive.openBox();
              await hive.addToken(data[1]);
              await hive.addId(event.username);
              await hive.userBox.close();
              yield Signed(connection: connection, res: true);
            } else {
              yield Signed(connection: connection, res: false);
            }
          } else {
            yield Signed(connection: connection, res: false);
          }
        } else {
          yield Signed(connection: connection, res: false);
        }
      } else {
        yield Signed(connection: connection, res: false);
      }
    }
  }
}
