import 'package:comments/core/errors/failure.dart';
import 'package:comments/features/comments/data/data_source/comments_remote_data_source.dart';
import 'package:comments/features/comments/domain/entites/comment_entity.dart';
import 'package:comments/features/comments/domain/repository/comments_repository.dart';
import 'package:fpdart/fpdart.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsRemoteDataSource commentsRemoteDataSource;

  CommentsRepositoryImpl({required this.commentsRemoteDataSource});

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(
      int start, int limit) async {
    try {
      final data = await commentsRemoteDataSource.getComments(start, limit);
      if (data.isNotEmpty) {
        return Right(
            data.map((commentModel) => commentModel.toEntity()).toList());
      } else {
        return Left(Failure("No commentes found"));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
