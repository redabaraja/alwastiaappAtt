import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';

class GetLinkedClassesState {}

class InitState extends GetLinkedClassesState {}

class LoadingState2 extends GetLinkedClassesState {}

class MyLinkedClasses extends GetLinkedClassesState {
  late bool connection;
  late List<ClassModel2> data;
  MyLinkedClasses({required this.data, required this.connection});
}
