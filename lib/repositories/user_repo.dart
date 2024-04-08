import 'package:ecom/clients/api_client/api_client.dart';
import 'package:ecom/clients/login.dart';
import 'package:ecom/repositories/repo_client/base_repo.dart';

const kTokenField = "t";

class UserRepo extends BaseRepo {
  late LoginApi loginApi;
  UserRepo(ApiClient client) : super(client) {
    loginApi = LoginApi(client);
  }

  Future<String> login({
    required String username,
    required String password,
  }) async {
    try {
      return await loginApi.login(username: username, password: password);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
