import 'package:comments/features/authentication/data/data_source/auth_remote_data_source.dart';
import 'package:comments/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:comments/features/authentication/domain/repository/auth_repository.dart';
import 'package:comments/features/authentication/domain/usecase/login_user_usecase.dart';
import 'package:comments/features/authentication/domain/usecase/logout_user_usecase.dart';
import 'package:comments/features/authentication/domain/usecase/register_user_usecase.dart';
import 'package:comments/features/authentication/presentation/provider/login_viewmodel.dart';
import 'package:comments/features/authentication/presentation/provider/register_viewmodel.dart';
import 'package:comments/features/comments/data/data_source/comments_remote_data_source.dart';
import 'package:comments/features/comments/data/repository/comments_repository_impl.dart';
import 'package:comments/features/comments/domain/repository/comments_repository.dart';
import 'package:comments/features/comments/domain/usecase/get_comments_usecase.dart';
import 'package:comments/features/comments/presentation/provider/comments_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Firebase
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);

  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setDefaults({'mask_email': false});
  await remoteConfig.fetchAndActivate();

  serviceLocator.registerSingleton<FirebaseRemoteConfig>(remoteConfig);
  _registerDataSources();
  _registerRepositories();
  _registerUseCase();
  _registerViewModels();
}

void _registerViewModels() {
  serviceLocator
    ..registerFactory(() =>
        CommentsViewModel(serviceLocator(), serviceLocator(), serviceLocator()))
    ..registerFactory(
        () => RegisterViewModel(registerUserUseCase: serviceLocator()))
    ..registerFactory(() => LoginViewModel(loginUserUseCase: serviceLocator()));
}

void _registerUseCase() {
  serviceLocator
    ..registerFactory(() => GetCommentsUseCase(serviceLocator()))
    ..registerFactory(() => RegisterUserUseCase(serviceLocator()))
    ..registerFactory(() => LoginUserUseCase(serviceLocator()))
    ..registerFactory(() => LogoutUserUseCase(serviceLocator()));
}

void _registerRepositories() {
  serviceLocator
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: serviceLocator()),
    )
    ..registerLazySingleton<CommentsRepository>(
      () => CommentsRepositoryImpl(commentsRemoteDataSource: serviceLocator()),
    );
}

void _registerDataSources() {
  serviceLocator
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
              firebaseAuth: serviceLocator(),
              firestore: serviceLocator(),
            ))
    ..registerLazySingleton<CommentsRemoteDataSource>(
        () => CommentsRemoteDataSourceImpl());
}
