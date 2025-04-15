import 'package:flutter/material.dart';

import 'customization_model.dart';

/// Customization model for text field components
class TextFieldCustomizationModel extends CustomizationModel {
  String labelText;
  String hintText;
  bool obscureText;
  Color fillColor;
  Color textColor;
  double borderRadius;
  bool hasBorder;
  bool showEditIcon;

  TextFieldCustomizationModel({
    this.labelText = 'Label',
    this.hintText = 'Enter text',
    this.obscureText = false,
    this.fillColor = Colors.white,
    this.textColor = Colors.black,
    this.borderRadius = 8.0,
    this.hasBorder = true,
    this.showEditIcon = false,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'labelText': labelText,
      'hintText': hintText,
      'obscureText': obscureText,
      'fillColor': fillColor.value,
      'textColor': textColor.value,
      'borderRadius': borderRadius,
      'hasBorder': hasBorder,
      'showEditIcon': showEditIcon,
    };
  }

  @override
  CustomizationModel fromMap(Map<String, dynamic> map) {
    return TextFieldCustomizationModel(
      labelText: map['labelText'] ?? 'Label',
      hintText: map['hintText'] ?? 'Enter text',
      obscureText: map['obscureText'] ?? false,
      fillColor: Color(map['fillColor'] ?? Colors.white.value),
      textColor: Color(map['textColor'] ?? Colors.black.value),
      borderRadius: map['borderRadius'] ?? 8.0,
      hasBorder: map['hasBorder'] ?? true,
      showEditIcon: map['showEditIcon'] ?? false,
    );
  }

  TextFieldCustomizationModel copyWith({
    String? labelText,
    String? hintText,
    bool? obscureText,
    Color? fillColor,
    Color? textColor,
    double? borderRadius,
    bool? hasBorder,
    bool? showEditIcon,
  }) {
    return TextFieldCustomizationModel(
      labelText: labelText ?? this.labelText,
      hintText: hintText ?? this.hintText,
      obscureText: obscureText ?? this.obscureText,
      fillColor: fillColor ?? this.fillColor,
      textColor: textColor ?? this.textColor,
      borderRadius: borderRadius ?? this.borderRadius,
      hasBorder: hasBorder ?? this.hasBorder,
      showEditIcon: showEditIcon ?? this.showEditIcon,
    );
  }
}
