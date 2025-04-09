import 'package:flutter/material.dart';

/// A reusable switch widget for customization panels
class CustomSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onChanged;

  const CustomSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Switch(value: value, onChanged: onChanged)],
      ),
    );
  }
}
