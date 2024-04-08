import 'package:ecom/clients/api_client/api_client.dart';

const String kLogin = "/auth/login";

class LoginApi {
  final ApiClient client;
  LoginApi(this.client);

  Future<String> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await client.callRequest(
        Method.post,
        kLogin,
        params: {
          "identifier": username,
          "password": password,
        },
      );

      return response;
    } on Exception catch (_) {
      rethrow;
    }
  }
}
