// ignore_for_file: overridden_fields

import 'package:http_interceptor/http_interceptor.dart';

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  bool shouldAttemptRetryOnException(Exception reason) => false;

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      return true;
    }
    return false;
  }

  @override
  final int maxRetryAttempts = 1;
}
