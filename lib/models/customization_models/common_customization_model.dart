import 'package:flutter/material.dart';
import 'customization_model.dart';

/// A common customization model that can be used for any component.
/// This model provides basic customization options that are applicable to most widgets.
class CommonCustomizationModel extends CustomizationModel {
  /// Primary color for the component
  Color primaryColor;

  /// Secondary color for the component
  Color secondaryColor;

  /// Text color for the component
  Color textColor;

  /// Background color for the component
  Color backgroundColor;

  /// Border radius for the component
  double borderRadius;

  /// Whether the component has a border
  bool hasBorder;

  /// Border color for the component
  Color borderColor;

  /// Border width for the component
  double borderWidth;

  /// Padding for the component
  double padding;

  /// Whether the component is enabled
  bool enabled;

  /// Scale factor for the component
  double scale;

  CommonCustomizationModel({
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.blueAccent,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.borderRadius = 8.0,
    this.hasBorder = false,
    this.borderColor = Colors.grey,
    this.borderWidth = 1.0,
    this.padding = 16.0,
    this.enabled = true,
    this.scale = 1.0,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'primaryColor': primaryColor.value,
      'secondaryColor': secondaryColor.value,
      'textColor': textColor.value,
      'backgroundColor': backgroundColor.value,
      'borderRadius': borderRadius,
      'hasBorder': hasBorder,
      'borderColor': borderColor.value,
      'borderWidth': borderWidth,
      'padding': padding,
      'enabled': enabled,
      'scale': scale,
    };
  }

  @override
  CustomizationModel fromMap(Map<String, dynamic> map) {
    return CommonCustomizationModel(
      primaryColor: Color(map['primaryColor'] ?? Colors.blue.value),
      secondaryColor: Color(map['secondaryColor'] ?? Colors.blueAccent.value),
      textColor: Color(map['textColor'] ?? Colors.black.value),
      backgroundColor: Color(map['backgroundColor'] ?? Colors.white.value),
      borderRadius: map['borderRadius'] ?? 8.0,
      hasBorder: map['hasBorder'] ?? false,
      borderColor: Color(map['borderColor'] ?? Colors.grey.value),
      borderWidth: map['borderWidth'] ?? 1.0,
      padding: map['padding'] ?? 16.0,
      enabled: map['enabled'] ?? true,
      scale: map['scale'] ?? 1.0,
    );
  }

  CommonCustomizationModel copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? textColor,
    Color? backgroundColor,
    double? borderRadius,
    bool? hasBorder,
    Color? borderColor,
    double? borderWidth,
    double? padding,
    bool? enabled,
    double? scale,
  }) {
    return CommonCustomizationModel(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      hasBorder: hasBorder ?? this.hasBorder,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      padding: padding ?? this.padding,
      enabled: enabled ?? this.enabled,
      scale: scale ?? this.scale,
    );
  }
}
