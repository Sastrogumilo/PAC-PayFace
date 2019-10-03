import 'package:equatable/equatable.dart';
//import 'package:meta/meta.dart';

abstract class KameraProfilEvent extends Equatable{
  KameraProfilEvent([List props = const[]]):super([props]);
}

class KameraProfilStart extends KameraProfilEvent {
  @override 
  String toString() => 'KameraProfilStart';
}
