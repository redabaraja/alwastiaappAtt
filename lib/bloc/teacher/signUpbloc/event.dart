

import 'package:equatable/equatable.dart';

class SignUpEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class Signing extends SignUpEvent{
  late String username;
  late String password;
  late String name;
  late String number;
  late String address;
  Signing({required this.username,required this.password,required this.name,required this.address,required this.number});
}

