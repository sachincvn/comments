import 'package:comments/core/errors/failure.dart';
import 'package:comments/core/usecases/usecase.dart';
import 'package:comments/features/authentication/domain/entities/user_entity.dart';
import 'package:comments/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RegisterUserUseCase implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) async {
    return await repository.registerUser(
        params.name, params.email, params.password);
  }
}

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams(
      {required this.name, required this.email, required this.password});
}
