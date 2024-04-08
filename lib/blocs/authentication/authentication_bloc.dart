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
          if (hasToken) {
            // TODO: yield
            // final user = await userRepo.user();
            emit(AuthenticationAuthenticated());
          } else {
            emit(AuthenticationUnauthenticated());
          }
        } on Exception catch (_) {
          emit(AuthenticationFailed());
        }
      }
      if (event is DoLogin) {
        emit(AuthenticationLoading());
        try {
          await userRepo.login(
              username: event.username, password: event.password);
          emit(AuthenticationAuthenticated());
        } on Exception catch (_) {
          emit(AuthenticationUninitialized());
        }
      }
      if (event is LoggedIn) {
        emit(AuthenticationLoading());
        await repo
            .get<SessionManager>()
            .persistAuthentication(event.authentication);
        try {
          // TODO: yield
          // final user = await userRepo.user();
          final bool hasToken = await repo.get<SessionManager>().hasToken();
          if (hasToken) {
            // TODO: yield
            // final user = await userRepo.user();
            emit(AuthenticationAuthenticated());
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
