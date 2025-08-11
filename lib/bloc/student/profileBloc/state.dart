import 'dart:io';

import 'package:alwastia/bloc/student/profileBloc/model.dart';

class ProfileState {}

class InitState extends ProfileState {}

class LoadingState extends ProfileState {}

class LoadingState2 extends ProfileState {}

class GetProfileImage extends ProfileState {
  late String imagePath;

  GetProfileImage({required this.imagePath});
}

class UserInfo extends ProfileState {
  late UserModel data;
  late File file;
  late bool fileExist;

  UserInfo({
    required this.file,
    required this.fileExist,
    required this.data,
  });
}


