import 'package:flutter/material.dart';

import '/components/otp_input/otp_textfield.dart';
import 'customization_model.dart';

/// Customization model for OTP text field components
class OtpTextFieldCustomizationModel extends CustomizationModel {
  int length;
  double spacing;
  StyleType styleType;
  Color borderColor;
  Color focusBorderColor;
  double borderWidth;
  
  OtpTextFieldCustomizationModel({
    this.length = 4,
    this.spacing = 8.0,
    this.styleType = StyleType.bordered,
    this.borderColor = Colors.grey,
    this.focusBorderColor = Colors.blue,
    this.borderWidth = 2.0,
  });
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'length': length,
      'spacing': spacing,
      'styleType': styleType.index,
      'borderColor': borderColor.value,
      'focusBorderColor': focusBorderColor.value,
      'borderWidth': borderWidth,
    };
  }
  
  @override
  CustomizationModel fromMap(Map<String, dynamic> map) {
    return OtpTextFieldCustomizationModel(
      length: map['length'] ?? 4,
      spacing: map['spacing'] ?? 8.0,
      styleType: StyleType.values[map['styleType'] ?? 0],
      borderColor: Color(map['borderColor'] ?? Colors.grey.value),
      focusBorderColor: Color(map['focusBorderColor'] ?? Colors.blue.value),
      borderWidth: map['borderWidth'] ?? 2.0,
    );
  }
  
  OtpTextFieldCustomizationModel copyWith({
    int? length,
    double? spacing,
    StyleType? styleType,
    Color? borderColor,
    Color? focusBorderColor,
    double? borderWidth,
  }) {
    return OtpTextFieldCustomizationModel(
      length: length ?? this.length,
      spacing: spacing ?? this.spacing,
      styleType: styleType ?? this.styleType,
      borderColor: borderColor ?? this.borderColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }
}