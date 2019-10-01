import 'package:equatable/equatable.dart';

abstract class TopUpState extends Equatable{
  TopUpState([List props = const[]]):super([props]);
}

class TopUpLoaded extends TopUpState {
  @override 
  String toString() => 'TopUpLoaded';
}

class TopUpGagal extends TopUpState {
  @override 
  String toString() => 'TopUpGagal';
}