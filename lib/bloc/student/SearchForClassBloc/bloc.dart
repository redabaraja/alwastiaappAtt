import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/event.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/model.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/repository.dart';
import 'package:alwastia/bloc/student/SearchForClassBloc/state.dart';
import 'package:alwastia/bloc/student/loginBloc/local.dart';
import 'package:alwastia/consts.dart';

class SearchForClassBloc
    extends Bloc<SearchForCLassEvent, SearchForClassState> {
  SearchForClassesRepo repo = SearchForClassesRepo();

  SearchForClassBloc(super.initialState);
  @override
  SearchForClassState get initialState => InitState();
  LocalData hive = LocalData();

  @override
  Stream<SearchForClassState> mapEventToState(
      SearchForCLassEvent event) async* {
    if (event is Search) {
      print('start search');
      yield LoadingState();
      bool connection = await hasNetwork();
      if (connection) {
        ClassModel2 data = await repo.search(event.ky);
        yield SearchRes(data: data, connection: connection);
      } else {
        // yield SearchRes(
        //     data: ClassModel2(
        //         date: '',
        //         descr: '',
        //         id: 0,
        //         ky: '',
        //         logo: '',
        //         name: '',
        //         instructor: '',
        //         stdCount: 0),
        //     connection: connection);
      }
    } 
  }
}
