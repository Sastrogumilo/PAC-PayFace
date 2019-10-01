import 'package:equatable/equatable.dart';
//import 'package:meta/meta.dart';

abstract class TopUpEvent extends Equatable{
  TopUpEvent([List props = const[]]):super([props]);
}

class TopUpStart extends TopUpEvent {
  @override 
  String toString() => 'TopUpStart';
}
