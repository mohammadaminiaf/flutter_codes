import 'package:flutter/material.dart';

import 'customization_model.dart';

/// Customization model for button components
class ButtonCustomizationModel extends CustomizationModel {
  String text;
  Color backgroundColor;
  Color textColor;
  final double fontSize;
  double borderRadius;
  bool isLoading;
  bool isOutlined;
  double elevation;
  double width;
  double height;
  bool enabled;

  ButtonCustomizationModel({
    this.text = 'Button',
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.borderRadius = 28.0,
    this.isLoading = false,
    this.isOutlined = false,
    this.elevation = 4.0,
    this.width = 200.0,
    this.height = 52.0,
    this.enabled = true,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'backgroundColor': backgroundColor.r,
      'textColor': textColor.r,
      'fontSize': fontSize,
      'borderRadius': borderRadius,
      'isLoading': isLoading,
      'isOutlined': isOutlined,
      'elevation': elevation,
      'width': width,
      'height': height,
      'enabled': enabled,
    };
  }

  @override
  CustomizationModel fromMap(Map<String, dynamic> map) {
    return ButtonCustomizationModel(
      text: map['text'] ?? 'Button',
      backgroundColor: Color(map['backgroundColor'] ?? Colors.blue.r),
      textColor: Color(map['textColor'] ?? Colors.white.r),
      fontSize: map['fontSize'] ?? 16.0,
      borderRadius: map['borderRadius'] ?? 28.0,
      isLoading: map['isLoading'] ?? false,
      isOutlined: map['isOutlined'] ?? false,
      elevation: map['elevation'] ?? 4.0,
      width: map['width'] ?? 200.0,
      height: map['height'] ?? 52.0,
      enabled: map['enabled'] ?? true,
    );
  }

  ButtonCustomizationModel copyWith({
    String? text,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
    double? borderRadius,
    bool? isLoading,
    bool? isOutlined,
    double? elevation,
    double? width,
    double? height,
    bool? enabled,
  }) {
    return ButtonCustomizationModel(
      text: text ?? this.text,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      fontSize: fontSize ?? this.fontSize,
      borderRadius: borderRadius ?? this.borderRadius,
      isLoading: isLoading ?? this.isLoading,
      isOutlined: isOutlined ?? this.isOutlined,
      elevation: elevation ?? this.elevation,
      width: width ?? this.width,
      height: height ?? this.height,
      enabled: enabled ?? this.enabled,
    );
  }
}
