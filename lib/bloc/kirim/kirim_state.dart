import 'package:equatable/equatable.dart';

abstract class KirimState extends Equatable{
  KirimState([List props = const[]]):super([props]);
}

class KirimLoaded extends KirimState {
  @override 
  String toString() => 'KirimLoaded';
}

class KirimGagal extends KirimState {
  @override 
  String toString() => 'KirimGagal';
}