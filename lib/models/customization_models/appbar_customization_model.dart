import 'package:flutter/material.dart';

import 'customization_model.dart';

/// Customization model for app bar components
class AppBarCustomizationModel extends CustomizationModel {
  String title;
  bool showBackArrow;
  bool centerTitle;
  Color backgroundColor;
  Color iconColor;
  double elevation;
  
  AppBarCustomizationModel({
    this.title = 'App Bar Title',
    this.showBackArrow = true,
    this.centerTitle = false,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.elevation = 0.0,
  });
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'showBackArrow': showBackArrow,
      'centerTitle': centerTitle,
      'backgroundColor': backgroundColor.value,
      'iconColor': iconColor.value,
      'elevation': elevation,
    };
  }
  
  @override
  CustomizationModel fromMap(Map<String, dynamic> map) {
    return AppBarCustomizationModel(
      title: map['title'] ?? 'App Bar Title',
      showBackArrow: map['showBackArrow'] ?? true,
      centerTitle: map['centerTitle'] ?? false,
      backgroundColor: Color(map['backgroundColor'] ?? Colors.white.value),
      iconColor: Color(map['iconColor'] ?? Colors.black.value),
      elevation: map['elevation'] ?? 0.0,
    );
  }
  
  AppBarCustomizationModel copyWith({
    String? title,
    bool? showBackArrow,
    bool? centerTitle,
    Color? backgroundColor,
    Color? iconColor,
    double? elevation,
  }) {
    return AppBarCustomizationModel(
      title: title ?? this.title,
      showBackArrow: showBackArrow ?? this.showBackArrow,
      centerTitle: centerTitle ?? this.centerTitle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
      elevation: elevation ?? this.elevation,
    );
  }
}
