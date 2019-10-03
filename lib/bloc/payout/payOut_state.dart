import 'package:equatable/equatable.dart';

abstract class PayOutState extends Equatable{
  PayOutState([List props = const[]]):super([props]);
}

class PayOutLoaded extends PayOutState {
  @override 
  String toString() => 'PayOutLoaded';
}

class PayOutGagal extends PayOutState {
  @override 
  String toString() => 'PayOutGagal';
}