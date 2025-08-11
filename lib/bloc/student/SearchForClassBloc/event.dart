import 'package:equatable/equatable.dart';

class SearchForCLassEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class Search extends SearchForCLassEvent {
  late String ky;
  Search({required this.ky});
}
