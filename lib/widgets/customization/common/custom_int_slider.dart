import 'package:flutter/material.dart';

/// A reusable integer slider widget for customization panels
class CustomIntSlider extends StatelessWidget {
  final String label;
  final int value;
  final int min;
  final int max;
  final Function(double) onChanged;

  const CustomIntSlider({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value.toString()),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: max - min,
          label: value.toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}