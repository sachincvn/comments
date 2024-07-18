import 'package:comments/core/errors/failure.dart';
import 'package:comments/core/utils/show_snackbar.dart';
import 'package:comments/features/authentication/domain/entities/user_entity.dart';
import 'package:comments/features/authentication/domain/usecase/login_user_usecase.dart';
import 'package:comments/features/comments/presentation/pages/comments_page.dart';
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
    final Either<Failure, UserEntity> result =
        await loginUserUseCase(loginParams);
    result.fold(
      (failure) {
        showErrorSnackBar(context, failure.message);
      },
      (user) => {
        if (context.mounted)
          {Navigator.pushReplacementNamed(context, CommentsPage.routeName)}
      },
    );

    isLoading = false;
    notifyListeners();
  }
}
