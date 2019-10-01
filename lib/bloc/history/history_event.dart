import 'package:equatable/equatable.dart';
//import 'package:meta/meta.dart';

abstract class HistoryEvent extends Equatable{
  HistoryEvent([List props = const[]]):super([props]);
}

class HistoryStart extends HistoryEvent {
  @override 
  String toString() => 'HistoryStart';
}
