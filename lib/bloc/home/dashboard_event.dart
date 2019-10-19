import 'package:equatable/equatable.dart';
//import 'package:meta/meta.dart';

abstract class DashBoardEvent extends Equatable{
  DashBoardEvent([List props = const[]]):super([props]);
}

class DashBoardStart extends DashBoardEvent {  
  final saldoku;
  
  DashBoardStart({this.saldoku}):super([saldoku]);
  //LoginButtonPressed({this.username, this.password}):super([username, password]);
  
  @override 
  String toString() => 'DashboardStart';
}
