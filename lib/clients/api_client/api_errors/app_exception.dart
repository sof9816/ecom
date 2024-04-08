part 'bad_request_exception.dart';
part 'fetch_data_exception.dart';
part 'unauthorised_exception.dart';
part 'invalid_input_exception.dart';
part 'not_found_exception.dart';
part 'forbidden_exception.dart';
part 'content_exception.dart';

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}
