import 'package:equatable/equatable.dart';
//import 'package:meta/meta.dart';

abstract class DashBoardEvent extends Equatable{
  DashBoardEvent([List props = const[]]):super([props]);
}

class DashBoardStart extends DashBoardEvent {
  @override 
  String toString() => 'DashboardStart';
}
