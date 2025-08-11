import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ClassInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetImage extends ClassInfoEvent {
  late int id;
  GetImage({required this.id});
}
