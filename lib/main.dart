import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:tourguard/core/theme/theme.dart';
import 'package:tourguard/dependency_injection/dependency_injection_imports.dart';
import 'package:tourguard/features/auth/presentation/manager/sign_in_bloc/sign_in_bloc.dart';
import 'package:tourguard/features/auth/presentation/manager/sign_up_bloc/sign_up_bloc.dart';
import 'package:tourguard/features/auth/presentation/pages/signin_page.dart';
import 'package:tourguard/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  // runApp(
  //   DevicePreview(
  //     builder: (context) => const MyApp(),
  //   ),
  // );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<SignUpBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<SignInBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Sim Fu',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SignInPage(),
      ),
    );
  }
}
