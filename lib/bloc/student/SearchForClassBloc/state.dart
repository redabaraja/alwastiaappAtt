import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';

class SearchForClassState {}

class InitState extends SearchForClassState {}

class LoadingState extends SearchForClassState {}

class SearchRes extends SearchForClassState {
  late bool connection;
  late ClassModel2 data;
  SearchRes({required this.data, required this.connection});
}
