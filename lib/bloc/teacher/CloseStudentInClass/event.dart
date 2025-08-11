import 'package:equatable/equatable.dart';

class CloseStdEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CloseStd extends CloseStdEvent {
  late int stdId;
  CloseStd({required this.stdId});
}

class ActivateStd extends CloseStdEvent {
  late int stdId;
  ActivateStd({required this.stdId});
}
