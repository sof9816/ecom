import 'bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:ecom/repositories/repo_client/repos_register.dart';
import 'package:ecom/repositories/user_repo.dart';
import 'package:ecom/utils/session_manager.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepo userRepo;

  AuthenticationBloc({required this.userRepo})
      : super(AuthenticationUninitialized()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AppStarted) {
        emit(AuthenticationLoading());
        try {
          final bool hasToken = await repo.get<SessionManager>().hasToken();
          final user = await repo.get<SessionManager>().getAuthentication();
          if (hasToken && user != null) {
            emit(AuthenticationAuthenticated(user: user));
          } else {
            emit(AuthenticationUnauthenticated());
          }
        } on Exception catch (_) {
          emit(AuthenticationFailed());
        }
      }

      if (event is LoggedIn) {
        emit(AuthenticationLoading());
        await repo
            .get<SessionManager>()
            .persistAuthentication(event.authentication.toJson());
        try {
          final bool hasToken = await repo.get<SessionManager>().hasToken();
          if (hasToken) {
            emit(AuthenticationAuthenticated(user: event.authentication));
          } else {
            emit(AuthenticationUnauthenticated());
          }
        } on Exception catch (_) {
          emit(AuthenticationUninitialized());
        }
      }

      if (event is LoggedOut) {
        emit(AuthenticationLoading());
        await repo.get<SessionManager>().deleteToken();
        emit(AuthenticationUnauthenticated());
      }
    });
  }
}
