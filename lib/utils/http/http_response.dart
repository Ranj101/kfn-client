class HTTPResponse {
  final dynamic body;
  final int statusCode;
  final bool isSuccessful;

  HTTPResponse({
    required this.body,
    required this.statusCode,
    required this.isSuccessful,
  });
}
