import 'package:equatable/equatable.dart';
//import 'package:meta/meta.dart';

abstract class KonfirmasiEvent extends Equatable{
  KonfirmasiEvent([List props = const[]]):super([props]);
}

class KonfirmasiStart extends KonfirmasiEvent {
  @override 
  String toString() => 'KonfirmasiStart';
}
