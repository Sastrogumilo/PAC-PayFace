import 'package:equatable/equatable.dart';

abstract class PinState extends Equatable{
  PinState([List props = const[]]):super([props]);
}

class PinLoaded extends PinState {
  @override 
  String toString() => 'PinLoaded';
}

class PinGagal extends PinState {
  @override 
  String toString() => 'PinGagal';
}