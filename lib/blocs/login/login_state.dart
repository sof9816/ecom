
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}


class ResetEmailSent extends LoginState {
  @override
  List<Object> get props => [];
}

class ResetEmailFailed extends LoginState {
  final String exception;
  const ResetEmailFailed(this.exception);
  @override
  List<Object> get props => [];
}

class LoginSucceed extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailed extends LoginState {
  final String error;
  const LoginFailed(this.error);
  @override
  List<Object> get props => [error];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

