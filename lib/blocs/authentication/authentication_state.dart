import 'package:ecom/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final UserModel user;
  AuthenticationAuthenticated({required this.user});
  @override
  List<Object> get props => [];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  List<Object> get props => [AuthenticationUnauthenticated];
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {
  AuthenticationFailed();
  @override
  List<Object> get props => [AuthenticationFailed];
}
