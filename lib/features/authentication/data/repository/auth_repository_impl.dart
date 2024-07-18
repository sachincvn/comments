import 'package:comments/core/errors/failure.dart';
import 'package:comments/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:comments/features/authentication/domain/entities/user_entity.dart';
import 'package:comments/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> registerUser(
      String name, String email, String password) async {
    try {
      final userModel =
          await remoteDataSource.registerUser(name, email, password);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginUser(
      String email, String password) async {
    try {
      final userModel = await remoteDataSource.loginUser(email, password);
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
