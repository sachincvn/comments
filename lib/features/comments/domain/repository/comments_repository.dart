import 'package:comments/core/errors/failure.dart';
import 'package:comments/features/comments/domain/entites/comment_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<CommentEntity>>> getComments(
      int start, int limit);
}
