import 'package:comments/core/errors/failure.dart';
import 'package:comments/features/authentication/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> registerUser(
      String name, String email, String password);
  Future<Either<Failure, UserEntity>> loginUser(String email, String password);
  Future<Either<Failure, void>> logout();
}
