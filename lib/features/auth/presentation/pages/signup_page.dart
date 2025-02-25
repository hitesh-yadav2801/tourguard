import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourguard/core/constants/strings/asset_strings.dart';
import 'package:tourguard/core/constants/widgets/toast.dart';
import 'package:tourguard/core/theme/app_colors.dart';
import 'package:tourguard/features/auth/presentation/manager/sign_up_bloc/sign_up_bloc.dart';
import 'package:tourguard/features/auth/presentation/widgets/auth_field.dart';
import 'package:tourguard/features/auth/presentation/widgets/custom_button.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpBloc>().add(
        SignUpWithEmailAndPasswordEvent(
          email: usernameController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            AppToasts.successToast(
              context: context,
              message: 'Your account has been created successfully!',
            );
          } else if (state is SignUpError) {
            AppToasts.errorToast(
              context: context,
              message: state.message,
              title: 'Sign Up Error',
            );
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            bool isLoading = state is SignUpLoading;

            return Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: IgnorePointer(
                      ignoring: isLoading, // Prevents interaction during loading
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                'Create an\naccount',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              const SizedBox(height: 30),

                              /// Name Field
                              AuthField(
                                labelText: 'Name',
                                controller: nameController,
                                prefixIconPath: AssetStrings.personIconSvg,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Name is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

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
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              /// Confirm Password Field
                              AuthField(
                                labelText: 'Confirm Password',
                                controller: confirmPasswordController,
                                obscureText: true,
                                prefixIconPath: AssetStrings.lockIconSvg,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Confirm Password is required';
                                  }
                                  if (value != passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              /// Terms and Conditions
                              const Text.rich(
                                TextSpan(
                                  text: 'By clicking the ',
                                  style: TextStyle(fontSize: 12, color: Color(0xFF676767)),
                                  children: [
                                    TextSpan(
                                      text: 'Create Account',
                                      style: TextStyle(color: AppColors.primaryColor),
                                    ),
                                    TextSpan(
                                      text: ' button, you agree to our',
                                      style: TextStyle(fontSize: 12, color: Color(0xFF676767)),
                                    ),
                                    TextSpan(
                                      text: ' Terms and Conditions.',
                                      style: TextStyle(fontSize: 12, color: AppColors.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),

                              /// Create Account Button
                              CustomButton(
                                buttonText: 'Create Account',
                                onTap: isLoading ? null : () => _signUp(context),
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

                              /// Google & Apple Sign-in
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                      context.read<SignUpBloc>().add(SignUpWithGoogleEvent());
                                    },
                                    icon: Image.asset(
                                      AssetStrings.googleIcon,
                                      height: 55,
                                      width: 55,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (Platform.isIOS)
                                    IconButton(
                                      onPressed: () {
                                        // Apple sign-in action
                                      },
                                      icon: Image.asset(
                                        AssetStrings.appleIcon,
                                        height: 55,
                                        width: 55,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 20),
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
                              'Signing up...',
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
