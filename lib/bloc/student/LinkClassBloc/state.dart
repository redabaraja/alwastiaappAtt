class LinkClassState {}

class InitState extends LinkClassState {}

class LoadingStateForLinking extends LinkClassState {}

class LinkClassDone extends LinkClassState {
  late bool connection;
  late bool res;
  LinkClassDone({required this.connection, required this.res});
}
