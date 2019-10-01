import 'package:equatable/equatable.dart';

abstract class DashBoardState extends Equatable{
  DashBoardState([List props = const[]]):super([props]);
}

class DashBoardLoaded extends DashBoardState {
  @override 
  String toString() => 'DashboardLoaded';
}

class DashBoardGagal extends DashBoardState {
  @override 
  String toString() => 'DashboardGagal';
}