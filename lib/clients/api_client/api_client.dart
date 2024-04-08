import 'dart:convert';
import 'package:get_it/get_it.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:ecom/clients/api_client/api_errors/app_exception.dart';
import 'package:ecom/clients/api_client/client_interceptor.dart';
import 'package:ecom/clients/api_client/expired_token_retry_policy.dart';
import 'package:ecom/repositories/repo_client/repos_register.dart';
import 'package:ecom/utils/constants/constants.dart';
import 'package:ecom/utils/session_manager.dart';

void registerClient(String baseUrl) {
  final GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton(() => ApiClient(baseUrl: baseUrl));
}

class ApiClient {
  final String baseUrl;
  late InterceptedClient client;

  ApiClient({
    required this.baseUrl,
  }) {
    client = InterceptedClient.build(
      interceptors: [
        ClientInterceptor(),
      ],
      requestTimeout: const Duration(milliseconds: 5000),
      retryPolicy: ExpiredTokenRetryPolicy(),
    );
  }

  Future<dynamic> callRequest(
    Method method,
    String path, {
    Map<String, dynamic>? params = const {},
  }) {
    switch (method) {
      case Method.get:
        return getReq(path, params: params);
      case Method.post:
        return postReq(path, params: params);
    }
  }

  Future<dynamic> getReq(path,
      {Map<String, dynamic>? params = const {}}) async {
    Map<String, dynamic> responseJson;
    final url = (baseUrl + path).toUri();
    try {
      final response = await client.get(url, params: params);
      responseJson = await _returnResponse(response);
    } on AppException {
      rethrow;
    } on Exception {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> postReq(path, {params = const {}}) async {
    Map<String, dynamic> responseJson;
    final url = (baseUrl + path).toUri();
    try {
      final response = await client.post(url,
          body: params, encoding: Encoding.getByName("utf-8"));
      responseJson = await _returnResponse(response);
    } on AppException {
      rethrow;
    } on Exception {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> _returnResponse(http.Response response) async {
    Map<String, dynamic> responseJson =
        json.decode(utf8.decode(response.bodyBytes));
    var message = responseJson["message"] ?? "";

    isUserValid = true;
    switch (response.statusCode) {
      case 200:
      case 201:
        return responseJson;
      case 400:
        throw BadRequestException("$message");
      case 401:
        await repo.get<SessionManager>().deleteToken();
        isUserValid = false;
        throw UnauthorisedException("$message");
      case 403:
        throw ForbiddenException("$message");
      case 404:
        throw NotFoundException("$message");
      case 422:
        throw ContentException("$message");
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

enum Method { get, post }
