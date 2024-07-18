import 'package:comments/core/errors/failure.dart';
import 'package:comments/core/utils/show_snackbar.dart';
import 'package:comments/features/authentication/domain/entities/user.dart';
import 'package:comments/features/authentication/domain/usecase/login_user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class LoginViewModel with ChangeNotifier {
  final LoginUserUseCase loginUserUseCase;
  bool isLoading = false;

  LoginViewModel({required this.loginUserUseCase});

  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    LoginParams loginParams = LoginParams(email: email, password: password);
    final Either<Failure, User> result = await loginUserUseCase(loginParams);
    result.fold(
      (failure) {
        showErrorSnackBar(context, failure.message);
      },
      (user) {
        showSnackBar(context, 'Registration Successful!');
      },
    );

    isLoading = false;
    notifyListeners();
  }
}
