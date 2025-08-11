import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/bloc/student/getStdSemesters/model.dart';

class GetStdSemestersState {}

class InitState extends GetStdSemestersState {}

class LoadingState2 extends GetStdSemestersState {}

class MySemesters extends GetStdSemestersState {
  late bool connection;
  late List<SemesterModel > data;
  MySemesters({required this.data, required this.connection});
}
