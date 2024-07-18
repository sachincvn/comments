import 'package:comments/core/errors/rest_response_exception.dart';

class Failure {
  final String? message;

  Failure([this.message = "Something Went Wrong !"]);

  factory Failure.handleException(Object e) {
    if (e is RestResponseException) {
      return Failure(e.message);
    } else if (e is Exception) {
      return Failure(e.toString());
    }
    return Failure("Something Went Wrong !");
  }
}
