part of 'dependency_injection_imports.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await initFirebaseInstances();
  await initAuthModule();
}

Future<void> initFirebaseInstances() async {
  /// Core services as singletons
  serviceLocator
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => GoogleSignIn());
}

Future<void> initAuthModule() async {
  /// Data sources as factories
  serviceLocator.registerFactory<AuthDataSource>(
    () => AuthDataSourceImpl(
      serviceLocator(),
      serviceLocator(),
      serviceLocator(),
    ),
  );

  /// Repositories as factories
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );

  /// Use cases
  serviceLocator
    ..registerFactory(() => SignInWithEmailAndPasswordUseCase(serviceLocator()))
    ..registerFactory(() => SignInWithGoogleUseCase(serviceLocator()))
    ..registerFactory(() => SignInWithAppleUseCase(serviceLocator()))
    ..registerFactory(() => SignUpWithEmailAndPasswordUseCase(serviceLocator()))
    ..registerFactory(() => SignUpWithGoogleUseCase(serviceLocator()))
    ..registerFactory(() => SignUpWithAppleUseCase(serviceLocator()))
    ..registerFactory(() => SignOutUseCase(serviceLocator()));

  /// Blocs as factories
  serviceLocator.registerFactory(
    () => SignUpBloc(
      signUpWithEmailAndPasswordUseCase: serviceLocator(),
      signUpWithGoogleUseCase: serviceLocator(),
      signUpWithAppleUseCase: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => SignInBloc(
      signInWithEmailAndPasswordUseCase: serviceLocator(),
      signInWithGoogleUseCase: serviceLocator(),
      signInWithAppleUseCase: serviceLocator(),
    ),
  );
}
