import 'package:alwastia/bloc/teacher/getMyClassesBloc/model.dart';

class GetClassesState2 {}

class InitState extends GetClassesState2 {}

class LoadingState2 extends GetClassesState2 {}

class MyClosingClasses extends GetClassesState2 {
  late bool connection;
  late List<ClassModel> data;
  MyClosingClasses({required this.data,required this.connection});
}
