import 'package:comments/core/errors/rest_response_exception.dart';
import 'package:comments/core/remote/rest_service_base.dart';

import '../models/comment_model.dart';

abstract class CommentsRemoteDataSource {
  Future<List<CommentModel>> getComments(int start, int limit);
}

class CommentsRemoteDataSourceImpl extends RestServiceBase
    implements CommentsRemoteDataSource {
  @override
  Future<List<CommentModel>> getComments(int start, int limit) async {
    final restRequest =
        createGetRequest("comments?_start=$start&_limit=$limit");
    final response = await executeRequest(restRequest);
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      return data.map((json) => CommentModel.fromJson(json)).toList();
    } else {
      throw RestResponseException(
        message: 'Failed to load comments',
      );
    }
  }
}
