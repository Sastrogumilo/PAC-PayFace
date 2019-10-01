import 'package:equatable/equatable.dart';
//import 'package:meta/meta.dart';

abstract class PayOutEvent extends Equatable{
  PayOutEvent([List props = const[]]):super([props]);
}

class PayOutStart extends PayOutEvent {
  @override 
  String toString() => 'PayOutStart';
}
