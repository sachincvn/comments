import 'package:comments/core/errors/failure.dart';
import 'package:comments/core/usecases/usecase.dart';
import 'package:comments/features/authentication/domain/entities/user_entity.dart';
import 'package:comments/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginUserUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await repository.loginUser(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
