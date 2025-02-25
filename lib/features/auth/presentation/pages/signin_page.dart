import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguard/core/constants/strings/asset_strings.dart';
import 'package:tourguard/core/constants/widgets/toast.dart';
import 'package:tourguard/core/theme/app_colors.dart';
import 'package:tourguard/features/auth/presentation/manager/sign_in_bloc/sign_in_bloc.dart';
import 'package:tourguard/features/auth/presentation/pages/forgot_password.dart';
import 'package:tourguard/features/auth/presentation/pages/signup_page.dart';
import 'package:tourguard/features/auth/presentation/widgets/auth_field.dart';
import 'package:tourguard/features/auth/presentation/widgets/custom_button.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignInBloc>().add(
        SignInWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            AppToasts.successToast(
              context: context,
              message: 'You have logged in successfully!',
              title: 'Login Success!',
            );
          } else if (state is SignInErrorState) {
            AppToasts.errorToast(
              context: context,
              message: state.message,
              title: 'Login Failed',
            );
          }
        },
        child: BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
            bool isLoading = state is SignInLoadingState;
            return Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: IgnorePointer(
                      ignoring: isLoading,
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                'Welcome\nBack!',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              const SizedBox(height: 30),

                              /// Email Field
                              AuthField(
                                labelText: 'Username or Email',
                                controller: usernameController,
                                prefixIconPath: AssetStrings.personIconSvg,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Email is required';
                                  }
                                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              /// Password Field
                              AuthField(
                                labelText: 'Password',
                                controller: passwordController,
                                obscureText: true,
                                prefixIconPath: AssetStrings.lockIconSvg,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Password is required';
                                  }
                                  return null;
                                },
                              ),

                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => const ForgotPasswordPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),

                              /// Login Button
                              CustomButton(
                                buttonText: 'Login',
                                onTap: isLoading ? null : () => _signIn(context),
                              ),
                              const SizedBox(height: 40),

                              /// OR Continue with
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      '- OR Continue with -',
                                      style: TextStyle(color: Color(0xFF575757)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              /// Social Login
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: isLoading
                                        ? null
                                        : () => context.read<SignInBloc>().add(SignInWithGoogle()),
                                    icon: Image.asset(
                                      AssetStrings.googleIcon,
                                      height: 55,
                                      width: 55,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (Platform.isIOS)
                                    IconButton(
                                      onPressed: isLoading
                                          ? null
                                          : () => context.read<SignInBloc>().add(SignInWithApple()),
                                      icon: Image.asset(
                                        AssetStrings.appleIcon,
                                        height: 55,
                                        width: 55,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              /// SignUp Prompt
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(color: Color(0xFF676767)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => const SignUpPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                /// Loading Indicator Overlay
                if (isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.6),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CupertinoActivityIndicator(radius: 16, color: Colors.white),
                            SizedBox(height: 12),
                            Text(
                              'Signing in...',
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
