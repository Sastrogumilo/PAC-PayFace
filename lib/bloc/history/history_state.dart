import 'package:equatable/equatable.dart';

abstract class HistoryState extends Equatable{
  HistoryState([List props = const[]]):super([props]);
}

class HistoryLoaded extends HistoryState {
  @override 
  String toString() => 'HistoryLoaded';
}

class HistoryGagal extends HistoryState {
  @override 
  String toString() => 'HistoryGagal';
}