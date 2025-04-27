import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iconsax/iconsax.dart';

import '/core/utils/validators.dart';

class PasswordTextfield extends HookWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;

  const PasswordTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final hidePassword = useState<bool>(false);

    return TextFormField(
      controller: controller,
      obscureText: hidePassword.value,
      validator: Validators.validatePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Iconsax.password_check),
        suffixIcon: IconButton(
          onPressed: () {
            hidePassword.value == !hidePassword.value;
          },
          icon: const Icon(Iconsax.eye_slash),
        ),
      ),
    );
  }
}
