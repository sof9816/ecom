part of 'app_exception.dart';

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "");
}
