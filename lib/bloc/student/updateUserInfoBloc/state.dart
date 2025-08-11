class UpdateUserInfoState {}

class InitState extends UpdateUserInfoState {}

class LoadingState extends UpdateUserInfoState {}

class UserData extends UpdateUserInfoState {
  late String name;
  late String email;
  late String phone;
  late String city;
  late String address;
  UserData(
      {required this.phone,
      required this.email,
      required this.name,
      required this.city,
      required this.address});
}

class UpdateState extends UpdateUserInfoState {
  late bool connection;
  late bool res;
  UpdateState({required this.connection, required this.res});
}
