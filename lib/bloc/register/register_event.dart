import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable{
  RegisterEvent([List props = const[]]):super([props]);

}

class TombolRegister extends RegisterEvent{
  final String username;
  final String email;
  final String password; 

  TombolRegister({
    this.username,
    this.email,
    this.password,
  }): super([username, email, password]);

  @override 
  String toString() => 'TombolRegister { username: $username, email: $email, password: $password}';
}