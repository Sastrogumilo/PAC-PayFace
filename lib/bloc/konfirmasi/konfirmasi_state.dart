import 'package:equatable/equatable.dart';

abstract class KonfirmasiState extends Equatable{
  KonfirmasiState([List props = const[]]):super([props]);
}

class KonfirmasiLoaded extends KonfirmasiState {
  @override 
  String toString() => 'KonfirmasiLoaded';
}

class KonfirmasiGagal extends KonfirmasiState {
  @override 
  String toString() => 'KonfirmasiGagal';
}