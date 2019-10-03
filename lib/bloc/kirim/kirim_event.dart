import 'package:equatable/equatable.dart';
//import 'package:meta/meta.dart';

abstract class KirimEvent extends Equatable{
  KirimEvent([List props = const[]]):super([props]);
}

class KirimStart extends KirimEvent {
  @override 
  String toString() => 'KirimStart';
}
