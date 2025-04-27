import 'package:flutter/material.dart';

/// A customized choice chip that can act like a radio button.
class TChoiceChip extends StatelessWidget {
  /// Create a chip that acts like a radio button.
  ///
  /// Parameters:
  ///   - text: The label text for the chip.
  ///   - selected: Whether the chip is currently selected.
  ///   - onSelected: Callback function when the chip is selected.
  ///   - color: Optional color for the chip. If provided, renders as a circular color chip.
  const TChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
    this.color,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final bool isColorChip = color != null;

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        avatar: isColorChip ? CircleAvatar(
          backgroundColor: color,
          radius: 25,
        ) : null,
        selected: selected,
        onSelected: onSelected,
        backgroundColor: color,
        labelStyle: TextStyle(
          color: selected ? Colors.white : null,
        ),
        shape: isColorChip ? const CircleBorder() : null,
        label: isColorChip ? const SizedBox() : Text(text),
        padding: isColorChip ? const EdgeInsets.all(0) : null,
        labelPadding: isColorChip ? const EdgeInsets.all(0) : null,
      ),
    );
  }
}
