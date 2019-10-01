import 'package:equatable/equatable.dart';
//import 'package:meta/meta.dart';

abstract class KameraBayarEvent extends Equatable{
  KameraBayarEvent([List props = const[]]):super([props]);
}

class KameraBayarStart extends KameraBayarEvent {
  @override 
  String toString() => 'KameraBayarStart';
}
