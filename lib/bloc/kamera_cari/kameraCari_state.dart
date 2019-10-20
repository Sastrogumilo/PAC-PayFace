import 'package:equatable/equatable.dart';

abstract class KameraCariState extends Equatable{
  KameraCariState([List props = const[]]):super([props]);
}

class KameraCariLoaded extends KameraCariState {
  @override 
  String toString() => 'KameraCariLoaded';
}

class KameraCariGagal extends KameraCariState {
  @override 
  String toString() => 'KameraCariGagal';
}