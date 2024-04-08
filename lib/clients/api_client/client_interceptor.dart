import 'dart:io';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:ecom/repositories/repo_client/repos_register.dart';
import 'package:ecom/utils/session_manager.dart';

const String kAuthorizationHeader = "Authorization";

class ClientInterceptor implements InterceptorContract {
  late String authentication;
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      final Map<String, String> headers = Map.from(data.headers);
      headers[HttpHeaders.acceptHeader] = "application/json";
      final authentication =
          await repo.get<SessionManager>().getAuthentication();
      if (authentication != null) {
        String token = authentication;
        headers[kAuthorizationHeader] = "Bearer $token";
      }
      data.headers = headers;
    } catch (e) {
      throw UnimplementedError();
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    try {
      return data;
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
