import 'package:flutter/material.dart';

import 'customization_model.dart';

/// Customization model for chip components
class ChipCustomizationModel extends CustomizationModel {
  String text;
  bool selected;
  Color? chipColor;
  Color selectedTextColor;
  Color unselectedTextColor;
  Color selectedBackgroundColor;
  Color unselectedBackgroundColor;
  bool isColorChip;
  
  ChipCustomizationModel({
    this.text = 'Chip',
    this.selected = false,
    this.chipColor,
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = Colors.black,
    this.selectedBackgroundColor = Colors.blue,
    this.unselectedBackgroundColor = Colors.grey,
    this.isColorChip = false,
  });
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'selected': selected,
      'chipColor': chipColor?.value,
      'selectedTextColor': selectedTextColor.value,
      'unselectedTextColor': unselectedTextColor.value,
      'selectedBackgroundColor': selectedBackgroundColor.value,
      'unselectedBackgroundColor': unselectedBackgroundColor.value,
      'isColorChip': isColorChip,
    };
  }
  
  @override
  CustomizationModel fromMap(Map<String, dynamic> map) {
    return ChipCustomizationModel(
      text: map['text'] ?? 'Chip',
      selected: map['selected'] ?? false,
      chipColor: map['chipColor'] != null ? Color(map['chipColor']) : null,
      selectedTextColor: Color(map['selectedTextColor'] ?? Colors.white.value),
      unselectedTextColor: Color(map['unselectedTextColor'] ?? Colors.black.value),
      selectedBackgroundColor: Color(map['selectedBackgroundColor'] ?? Colors.blue.value),
      unselectedBackgroundColor: Color(map['unselectedBackgroundColor'] ?? Colors.grey.value),
      isColorChip: map['isColorChip'] ?? false,
    );
  }
  
  ChipCustomizationModel copyWith({
    String? text,
    bool? selected,
    Color? chipColor,
    Color? selectedTextColor,
    Color? unselectedTextColor,
    Color? selectedBackgroundColor,
    Color? unselectedBackgroundColor,
    bool? isColorChip,
  }) {
    return ChipCustomizationModel(
      text: text ?? this.text,
      selected: selected ?? this.selected,
      chipColor: chipColor ?? this.chipColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      unselectedTextColor: unselectedTextColor ?? this.unselectedTextColor,
      selectedBackgroundColor: selectedBackgroundColor ?? this.selectedBackgroundColor,
      unselectedBackgroundColor: unselectedBackgroundColor ?? this.unselectedBackgroundColor,
      isColorChip: isColorChip ?? this.isColorChip,
    );
  }
}
