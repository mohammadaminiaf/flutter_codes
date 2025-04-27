import 'package:flutter/material.dart';

import 'customization_model.dart';

/// Customization model for container components
class ContainerCustomizationModel extends CustomizationModel {
  double width;
  double height;
  double radius;
  bool showBorder;
  Color backgroundColor;
  Color borderColor;
  double padding;
  
  ContainerCustomizationModel({
    this.width = 200.0,
    this.height = 200.0,
    this.radius = 16.0,
    this.showBorder = false,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.grey,
    this.padding = 16.0,
  });
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'width': width,
      'height': height,
      'radius': radius,
      'showBorder': showBorder,
      'backgroundColor': backgroundColor.value,
      'borderColor': borderColor.value,
      'padding': padding,
    };
  }
  
  @override
  CustomizationModel fromMap(Map<String, dynamic> map) {
    return ContainerCustomizationModel(
      width: map['width'] ?? 200.0,
      height: map['height'] ?? 200.0,
      radius: map['radius'] ?? 16.0,
      showBorder: map['showBorder'] ?? false,
      backgroundColor: Color(map['backgroundColor'] ?? Colors.white.value),
      borderColor: Color(map['borderColor'] ?? Colors.grey.value),
      padding: map['padding'] ?? 16.0,
    );
  }
  
  ContainerCustomizationModel copyWith({
    double? width,
    double? height,
    double? radius,
    bool? showBorder,
    Color? backgroundColor,
    Color? borderColor,
    double? padding,
  }) {
    return ContainerCustomizationModel(
      width: width ?? this.width,
      height: height ?? this.height,
      radius: radius ?? this.radius,
      showBorder: showBorder ?? this.showBorder,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      padding: padding ?? this.padding,
    );
  }
}
