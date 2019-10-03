import 'package:equatable/equatable.dart';

abstract class KameraProfilState extends Equatable{
  KameraProfilState([List props = const[]]):super([props]);
}

class KameraProfilLoaded extends KameraProfilState {
  @override 
  String toString() => 'KameraProfilLoaded';
}

class KameraProfilGagal extends KameraProfilState {
  @override 
  String toString() => 'KameraProfilGagal';
}