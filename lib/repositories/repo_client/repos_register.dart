import 'package:ecom/repositories/user_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:ecom/clients/api_client/api_client.dart';
import 'package:ecom/utils/session_manager.dart';

final GetIt repo = GetIt.instance;

void registerRepositories() {
  final client = repo.get<ApiClient>();
  repo.registerLazySingleton<UserRepo>(() => UserRepo(client));
  repo.registerLazySingleton<SessionManager>(() => SessionManager());
}
