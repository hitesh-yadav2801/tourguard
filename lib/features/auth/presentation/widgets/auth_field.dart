import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String prefixIconPath;

  const AuthField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    required this.controller,
    this.validator,
    required this.prefixIconPath,
  });

  @override
  _AuthFieldState createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Color(0xFF676767),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Color(0xFFA8A8A9),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Color(0xFFA8A8A9),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5
          ),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            widget.prefixIconPath,
          ),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}
