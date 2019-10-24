import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class KirimState extends Equatable{
  KirimState([List props = const[]]):super([props]);
}

class KirimLoaded extends KirimState {
  @override 
  String toString() => 'KirimLoaded';
}

class KirimGagal extends KirimState {
  final String error;
  KirimGagal({@required this.error}):super([error]);
  
  @override 
  String toString() => 'KirimGagal {error: {$error}}';
}