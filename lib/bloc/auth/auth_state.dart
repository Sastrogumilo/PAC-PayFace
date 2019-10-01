import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthUninitial extends AuthState{
  @override 
  String toString() => 'AuthUninitial';
}

class AuthDikenal extends AuthState{
  @override 
  String toString() => 'AuthDikenal';
}

class AuthUnauth extends AuthState{
  @override 
  String toString() => 'AuthUnauth';
}
class AuthLoading extends AuthState{
  @override
  String toString() => 'AuthLoading';
}