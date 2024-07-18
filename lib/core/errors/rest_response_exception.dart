class RestResponseException implements Exception {
  final String message;
  final int? code;

  RestResponseException({required this.message, this.code});

  @override
  String toString() => 'RestResponseException: $message (code: $code)';
}
