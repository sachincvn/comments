import 'package:comments/core/errors/failure.dart';
import 'package:comments/core/usecases/usecase.dart';
import 'package:comments/features/comments/domain/entites/comment_entity.dart';
import 'package:comments/features/comments/domain/repository/comments_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCommentsUseCase
    implements UseCase<List<CommentEntity>, GetCommentsParams> {
  final CommentsRepository repository;

  GetCommentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<CommentEntity>>> call(
      GetCommentsParams params) async {
    return await repository.getComments(params.start, params.limit);
  }
}

class GetCommentsParams {
  final int start;
  final int limit;

  GetCommentsParams({required this.start, required this.limit});
}
