import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';

class GetClassesState {}

class InitState extends GetClassesState {}

class LoadingState2 extends GetClassesState {}

class MyClasses extends GetClassesState {
  late bool connection;
  late List<ClassModel> data;
  MyClasses({required this.data,required this.connection});
}

