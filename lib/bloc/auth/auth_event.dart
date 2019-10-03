import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]):super(props);

}

class AppStart extends AuthEvent {
  @override 
  String toString() => 'AppStart';
}

class LoggedIn extends AuthEvent {
  final ParseUser user;
  LoggedIn({this.user}): super([user]);

  @override 
  String toString() => 'LoggedIn: $user.name';
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';
}