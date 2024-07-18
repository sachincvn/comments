import 'package:comments/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final bool isObscureText;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  const AuthInputField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.errorMessage,
    this.isObscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 14, color: AppTheme.grayColor),
          ),
          validator: validator,
          obscureText: isObscureText,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.secondaryColor,
            fontWeight: FontWeight.w500,
          ),
          maxLines: maxLines,
          maxLength: maxLength,
          readOnly: readOnly,
          onTap: onTap,
        ),
      ],
    );
  }
}
