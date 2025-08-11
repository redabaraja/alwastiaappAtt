
import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class Loginn extends LoginEvent{
  late String username;
  late String password;
  late String type;
  Loginn({required this.username,required this.password,required this.type});
}
class UpdatePassWord extends LoginEvent {
  late String oldPassword;
  late String newPassword;
  UpdatePassWord({required this.newPassword, required this.oldPassword});
}

