import 'package:comments/core/errors/failure.dart';
import 'package:comments/core/utils/show_snackbar.dart';
import 'package:comments/features/authentication/domain/entities/user.dart';
import 'package:comments/features/authentication/domain/usecase/register_user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class RegisterViewModel with ChangeNotifier {
  final RegisterUserUseCase registerUserUseCase;
  bool isLoading = false;

  RegisterViewModel({required this.registerUserUseCase});

  Future<void> registerUser(
      String name, String email, String password, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    RegisterParams registerParams =
        RegisterParams(name: name, email: email, password: password);

    final Either<Failure, User> result =
        await registerUserUseCase(registerParams);
    result.fold(
      (failure) {
        showErrorSnackBar(context, failure.message);
      },
      (user) {
        showSnackBar(context, 'Login Successful!');
      },
    );

    isLoading = false;
    notifyListeners();
  }
}
