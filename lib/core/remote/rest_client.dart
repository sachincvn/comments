import 'package:comments/core/constants/rest_resources.dart';
import 'package:dio/dio.dart';

class RestClient {
  Dio dio = Dio();

  RestClient() {
    if (dio.options.baseUrl.isEmpty) {
      dio.options.baseUrl = RestResources.commentsBaseUrl;
    }
  }
}

class RestRequest extends Options {
  final String path;
  final dynamic body;
  RequestMethod? requestMethod = RequestMethod.get;

  RestRequest(this.path, this.body, {RequestMethod? method, dynamic}) {
    requestMethod = method;
  }

  setRequestHeaders(Map<String, dynamic>? headers) {
    super.headers = headers;
  }
}

enum RequestMethod { get, post, put, delete }
