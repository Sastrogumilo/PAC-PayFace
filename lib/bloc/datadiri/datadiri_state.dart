import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DataDiriState extends Equatable {
  DataDiriState([List props = const[]]):super(props);
}

class DataDiriInitial extends DataDiriState{
  @override
  String toString() => 'DataDiriInitial';
}

class DataDiriLoading extends DataDiriState{
  @override 
  String toString() => 'DataDiriLoading';
}

class DataDiriGagal extends DataDiriState{
  final String error;
  DataDiriGagal({@required this.error}):super([error]);

  @override 
  String toString() => 'DataDiriGagal {error: $error}';
}

class DataDiriBerhasil extends DataDiriState{
  @override 
  String toString() => 'DataDiriBerhasil';
}