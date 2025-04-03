import 'package:flutter/material.dart';

class PasswordTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Color? fillColor;
  final Color? textColor;
  final Color? cursorColor;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final bool? enabled;
  final String? Function(String?)? validator;

  PasswordTextfield({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.fillColor,
    this.textColor,
    this.cursorColor,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.contentPadding,
    this.enabled,
    this.validator,
  });

  final ValueNotifier<bool> _hidePassword = ValueNotifier<bool>(true);

  String? _validatePassword(String? value) {
    if (validator != null) {
      return validator!(value);
    }
    
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _hidePassword,
      builder: (context, hidePassword, _) {
        return TextFormField(
          controller: controller,
          obscureText: hidePassword,
          validator: _validatePassword,
          enabled: enabled,
          style: style,
          cursorColor: cursorColor,
          decoration: InputDecoration(
            labelText: labelText ?? 'Password',
            hintText: hintText,
            prefixIcon: prefixIcon ?? const Icon(Icons.lock),
            suffixIcon: IconButton(
              onPressed: () {
                _hidePassword.value = !hidePassword;
              },
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            fillColor: fillColor,
            filled: fillColor != null,
            border: border,
            focusedBorder: focusedBorder,
            enabledBorder: enabledBorder,
            labelStyle: labelStyle,
            hintStyle: hintStyle,
            contentPadding: contentPadding,
          ),
        );
      },
    );
  }
}