import 'package:flutter/material.dart';
import '../../../widgets/customization/common/color_picker_dialog.dart';

/// A reusable color picker field widget for customization panels
class ColorPickerField extends StatelessWidget {
  final String label;
  final Color color;
  final Function(Color) onColorChanged;

  const ColorPickerField({
    super.key, 
    required this.label, 
    required this.color, 
    required this.onColorChanged
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        const Spacer(),
        GestureDetector(
          onTap: () {
            _showColorPicker(context, color, onColorChanged);
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }

  void _showColorPicker(BuildContext context, Color initialColor, Function(Color) onColorChanged) {
    showDialog(
      context: context,
      builder: (context) {
        Color selectedColor = initialColor;
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPickerDialog(
              pickerColor: initialColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onColorChanged(selectedColor);
                Navigator.of(context).pop();
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }
}