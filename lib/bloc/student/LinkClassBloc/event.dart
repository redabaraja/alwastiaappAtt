import 'package:equatable/equatable.dart';

class LinkCLassEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LinkClass extends LinkCLassEvent {
  late String ky;
  late String passcode;
  LinkClass({required this.ky, required this.passcode});
}
