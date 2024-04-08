import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent() : super();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [this];
}

class DoLogin extends AuthenticationEvent {
  final String username;
  final String password;

  const DoLogin(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class LoggedIn extends AuthenticationEvent {
  final String authentication;

  const LoggedIn({required this.authentication}) : super();

  @override
  String toString() => 'LoggedIn { token: $authentication }';

  @override
  List<Object> get props => [authentication];
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';

  @override
  List<Object> get props => [this];
}
