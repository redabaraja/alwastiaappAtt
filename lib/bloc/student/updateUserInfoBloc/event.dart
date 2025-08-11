import 'package:equatable/equatable.dart';

class UpdateUserInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserData extends UpdateUserInfoEvent {}

class UpdateData extends UpdateUserInfoEvent {
  late String name;
  late String email;
  late String phone;
  late String city;
  late String address;
  UpdateData(
      {required this.phone,
      required this.email,
      required this.name,
      required this.city,
      required this.address});
}
