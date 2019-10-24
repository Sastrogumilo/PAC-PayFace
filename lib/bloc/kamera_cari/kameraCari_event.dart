import 'package:equatable/equatable.dart';
//import 'package:meta/meta.dart';

abstract class KameraCariEvent extends Equatable{
  KameraCariEvent([List props = const[]]):super([props]);
}

class KameraCariStart extends KameraCariEvent {
  @override 
  String toString() => 'KameraCariStart';
}
