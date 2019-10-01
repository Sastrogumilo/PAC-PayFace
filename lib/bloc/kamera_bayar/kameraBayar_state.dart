import 'package:equatable/equatable.dart';

abstract class KameraBayarState extends Equatable{
  KameraBayarState([List props = const[]]):super([props]);
}

class KameraBayarLoaded extends KameraBayarState {
  @override 
  String toString() => 'KameraBayarLoaded';
}

class KameraBayarGagal extends KameraBayarState {
  @override 
  String toString() => 'KameraBayarGagal';
}