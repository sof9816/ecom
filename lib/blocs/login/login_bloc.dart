import 'package:bloc/bloc.dart';
import 'package:ecom/blocs/authentication/bloc.dart';
import 'package:ecom/blocs/login/bloc.dart';
import 'package:ecom/models/user.dart';
import 'package:ecom/repositories/user_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepo repository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({required this.repository, required this.authenticationBloc})
      : super(InitialLoginState()) {
    on<LoginEvent>((event, emit) async {
      if (event is DoLogin) {
        emit(LoginLoading());
        try {
          final UserModel auth = await repository.login(
              username: event.username, password: event.password);
          authenticationBloc.add(LoggedIn(authentication: auth));
          emit(LoginSucceed());
        } on Exception catch (e) {
          emit(LoginFailed(e.toString()));
        }
      }
    });
  }
}
