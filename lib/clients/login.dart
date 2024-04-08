import 'package:ecom/clients/api_client/api_client.dart';
import 'package:ecom/models/user.dart';

const String kLogin = "/auth/login";

class LoginApi {
  final ApiClient client;
  LoginApi(this.client);

  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await client.callRequest(
        Method.post,
        kLogin,
        params: {
          "username": username,
          "password": password,
        },
      );

      return UserModel.fromMap(response);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
