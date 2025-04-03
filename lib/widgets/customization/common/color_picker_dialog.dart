import 'package:flutter/material.dart';

/// A simple color picker dialog widget
class ColorPickerDialog extends StatefulWidget {
  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerDialog({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
  });

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.pickerColor;
  }

  @override
  Widget build(BuildContext context) {
    // A simple color grid
    final List<Color> colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      Colors.black,
      Colors.white,
    ];

    return SizedBox(
      width: 300,
      height: 300,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                currentColor = colors[index];
                widget.onColorChanged(currentColor);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: colors[index],
                border: Border.all(
                  color: currentColor == colors[index] ? Colors.black : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        },
      ),
    );
  }
}