
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class DoLogin extends LoginEvent {
  final String username;
  final String password;

  const DoLogin(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}