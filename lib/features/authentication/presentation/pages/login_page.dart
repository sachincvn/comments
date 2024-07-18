import 'package:comments/core/theme/app_theme.dart';
import 'package:comments/core/utils/show_snackbar.dart';
import 'package:comments/core/utils/validators.dart';
import 'package:comments/features/authentication/presentation/pages/register_page.dart';
import 'package:comments/features/authentication/presentation/provider/login_viewmodel.dart';
import 'package:comments/features/authentication/presentation/widgets/auth_app_bar_widget.dart';
import 'package:comments/features/authentication/presentation/widgets/auth_input_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      context.read<LoginViewModel>().loginUser(email, password, context);
    } else {
      showErrorSnackBar(context, "Please enter the valid details!");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: authAppBar("Comments"),
        backgroundColor: AppTheme.lightColor,
        body: Padding(
          padding:
              const EdgeInsets.only(bottom: 20, left: 14, right: 14, top: 80),
          child: Consumer<LoginViewModel>(
            builder: (context, viewModel, child) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthInputField(
                      labelText: "Email",
                      hintText: "Enter your email",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                    ),
                    const SizedBox(height: 10),
                    AuthInputField(
                      labelText: "Password",
                      hintText: "Enter your password",
                      controller: _passwordController,
                      isObscureText: true,
                      validator: Validators.validatePassword,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed:
                          viewModel.isLoading ? null : () => _login(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15)),
                      child: viewModel.isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.lightColor),
                            )
                          : const Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 16, color: AppTheme.lightColor),
                            ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: "New Here?",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w500),
                        children: [
                          const TextSpan(text: " "),
                          TextSpan(
                              style:
                                  const TextStyle(color: AppTheme.primaryColor),
                              text: "Signup",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage(),
                                      ));
                                }),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
