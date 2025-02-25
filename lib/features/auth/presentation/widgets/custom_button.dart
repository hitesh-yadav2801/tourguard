import 'package:flutter/material.dart';
import 'package:tourguard/core/theme/app_colors.dart';


class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;
  final Widget? child;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(5),
          child: Center(
            child: child ??
                Text(
                  buttonText,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
