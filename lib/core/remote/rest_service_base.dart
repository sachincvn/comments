import 'package:dio/dio.dart';
import 'package:comments/core/errors/rest_response_exception.dart';
import 'package:comments/core/remote/rest_client.dart';

abstract class RestServiceBase extends RestClient {
  Future<Response> executeRequest(RestRequest restRequest) async {
    try {
      if (restRequest.requestMethod == RequestMethod.get) {
        return await dio.get(restRequest.path, options: restRequest);
      } else if (restRequest.requestMethod == RequestMethod.post) {
        return await dio.post(restRequest.path,
            data: restRequest.body, options: restRequest);
      } else if (restRequest.requestMethod == RequestMethod.put) {
        return await dio.put(restRequest.path,
            data: restRequest.body, options: restRequest);
      } else if (restRequest.requestMethod == RequestMethod.delete) {
        return await dio.delete(restRequest.path,
            data: restRequest.body, options: restRequest);
      } else {
        throw Exception("Unknown Method");
      }
    } catch (error) {
      if (error is DioException) {
        throw RestResponseException(
            message: error.response!.data['message'] ?? error.toString());
      }
      rethrow;
    }
  }

  RestRequest createGetRequest(String resource, {dynamic body}) =>
      RestRequest(resource, null, method: RequestMethod.get);

  RestRequest createPostRequest(String resource, {dynamic body}) =>
      RestRequest(resource, body, method: RequestMethod.post);

  RestRequest createPutRequest(String resource, {dynamic body}) =>
      RestRequest(resource, body, method: RequestMethod.put);

  RestRequest createDeleteRequest(String resource, {dynamic body}) =>
      RestRequest(resource, body, method: RequestMethod.delete);
}
