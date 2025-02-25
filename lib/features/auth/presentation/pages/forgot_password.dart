import 'package:flutter/material.dart';
import 'package:tourguard/core/constants/strings/asset_strings.dart';
import 'package:tourguard/features/auth/presentation/widgets/auth_field.dart';
import 'package:tourguard/features/auth/presentation/widgets/custom_button.dart';


class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Forgot\npassword?',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(height: 30),

                // Email Address field
                AuthField(
                  labelText: 'Enter your email address',
                  controller: emailController,
                  prefixIconPath: AssetStrings.messageIconSvg,
                ),
                const SizedBox(height: 20),

                // Informational text
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '*',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        ' We will send you a message to set or reset your new password',
                        style: TextStyle(
                          color: Color(0xFF575757),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                CustomButton(
                  buttonText: 'Submit',
                  onTap: () {
                    // Handle submit action here
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
