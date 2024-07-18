import 'package:comments/core/theme/app_theme.dart';
import 'package:comments/core/utils/firebase_options.dart';
import 'package:comments/features/authentication/presentation/pages/login_page.dart';
import 'package:comments/features/authentication/presentation/pages/register_page.dart';
import 'package:comments/features/authentication/presentation/provider/login_viewmodel.dart';
import 'package:comments/features/authentication/presentation/provider/register_viewmodel.dart';
import 'package:comments/features/comments/presentation/pages/comments_page.dart';
import 'package:comments/features/comments/presentation/provider/comments_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:comments/core/di/injection_container.dart' as di;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.serviceLocator<RegisterViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.serviceLocator<LoginViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.serviceLocator<CommentsViewModel>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Comments',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routes: {
          LoginPage.routeName: (context) => const LoginPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          CommentsPage.routeName: (context) => const CommentsPage(),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CommentsPage();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
