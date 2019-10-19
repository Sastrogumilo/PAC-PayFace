import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]):super(props);

}

class LoginButtonPressed extends LoginEvent{
  
  final String username;
  final String password;

  LoginButtonPressed({this.username, this.password}):super([username, password]);

  @override 
  String toString() => 'LoginButtonPressed {email: $username, password: $password}';
}