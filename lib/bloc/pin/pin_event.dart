import 'package:equatable/equatable.dart';
//import 'package:meta/meta.dart';

abstract class PinEvent extends Equatable{
  PinEvent([List props = const[]]):super([props]);
}

class PinStart extends PinEvent {
  @override 
  String toString() => 'PinStart';
}
