import 'package:flutter/material.dart';

import '/components/otp_input/otp_textfield.dart';
import 'customization_model.dart';

/// Customization model for OTP text field components
class OtpTextFieldCustomizationModel extends CustomizationModel {
  int fieldCount; // Renamed from length for consistency with UI
  double spacing;
  StyleType styleType;
  Color borderColor;
  Color focusBorderColor;
  double borderWidth;
  Color fieldColor;
  Color textColor;
  double fieldSize;
  double borderRadius;
  bool obscureText;
  double width;
  double height;
  
  OtpTextFieldCustomizationModel({
    this.fieldCount = 4,
    this.spacing = 8.0,
    this.styleType = StyleType.bordered,
    this.borderColor = Colors.grey,
    this.focusBorderColor = Colors.blue,
    this.borderWidth = 2.0,
    this.fieldColor = Colors.white,
    this.textColor = Colors.black,
    this.fieldSize = 50.0,
    this.borderRadius = 8.0,
    this.obscureText = false,
    this.width = 60.0,
    this.height = 60.0,
  });
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'fieldCount': fieldCount,
      'spacing': spacing,
      'styleType': styleType.index,
      'borderColor': borderColor.value,
      'focusBorderColor': focusBorderColor.value,
      'borderWidth': borderWidth,
      'fieldColor': fieldColor.value,
      'textColor': textColor.value,
      'fieldSize': fieldSize,
      'borderRadius': borderRadius,
      'obscureText': obscureText,
      'width': width,
      'height': height,
    };
  }
  
  @override
  CustomizationModel fromMap(Map<String, dynamic> map) {
    return OtpTextFieldCustomizationModel(
      fieldCount: map['fieldCount'] ?? 4,
      spacing: map['spacing'] ?? 8.0,
      styleType: StyleType.values[map['styleType'] ?? 0],
      borderColor: Color(map['borderColor'] ?? Colors.grey.value),
      focusBorderColor: Color(map['focusBorderColor'] ?? Colors.blue.value),
      borderWidth: map['borderWidth'] ?? 2.0,
      fieldColor: Color(map['fieldColor'] ?? Colors.white.value),
      textColor: Color(map['textColor'] ?? Colors.black.value),
      fieldSize: map['fieldSize'] ?? 50.0,
      borderRadius: map['borderRadius'] ?? 8.0,
      obscureText: map['obscureText'] ?? false,
      width: map['width'] ?? 60.0,
      height: map['height'] ?? 60.0,
    );
  }
  
  OtpTextFieldCustomizationModel copyWith({
    int? fieldCount,
    double? spacing,
    StyleType? styleType,
    Color? borderColor,
    Color? focusBorderColor,
    double? borderWidth,
    Color? fieldColor,
    Color? textColor,
    double? fieldSize,
    double? borderRadius,
    bool? obscureText,
    double? width,
    double? height,
  }) {
    return OtpTextFieldCustomizationModel(
      fieldCount: fieldCount ?? this.fieldCount,
      spacing: spacing ?? this.spacing,
      styleType: styleType ?? this.styleType,
      borderColor: borderColor ?? this.borderColor,
      focusBorderColor: focusBorderColor ?? this.focusBorderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      fieldColor: fieldColor ?? this.fieldColor,
      textColor: textColor ?? this.textColor,
      fieldSize: fieldSize ?? this.fieldSize,
      borderRadius: borderRadius ?? this.borderRadius,
      obscureText: obscureText ?? this.obscureText,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}