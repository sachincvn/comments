import 'package:comments/core/errors/failure.dart';
import 'package:comments/features/authentication/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> registerUser(
      String name, String email, String password);
  Future<Either<Failure, User>> loginUser(String email, String password);
  Future<Either<Failure, void>> logout();
}
