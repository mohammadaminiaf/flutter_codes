import 'package:flutter/material.dart';

import 'customization_model.dart';

/// Customization model for list tile components
class ListTileCustomizationModel extends CustomizationModel {
  String title;
  String? subtitle;
  IconData leadingIcon;
  IconData? trailingIcon;
  Color backgroundColor;
  Color textColor;
  Color iconColor;
  double borderRadius;
  bool showDivider;
  
  ListTileCustomizationModel({
    this.title = 'List Tile',
    this.subtitle,
    this.leadingIcon = Icons.settings,
    this.trailingIcon,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.iconColor = Colors.blue,
    this.borderRadius = 0.0,
    this.showDivider = false,
  });
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'leadingIcon': leadingIcon.codePoint,
      'trailingIcon': trailingIcon?.codePoint,
      'backgroundColor': backgroundColor.value,
      'textColor': textColor.value,
      'iconColor': iconColor.value,
      'borderRadius': borderRadius,
      'showDivider': showDivider,
    };
  }
  
  @override
  CustomizationModel fromMap(Map<String, dynamic> map) {
    return ListTileCustomizationModel(
      title: map['title'] ?? 'List Tile',
      subtitle: map['subtitle'],
      leadingIcon: IconData(map['leadingIcon'] ?? Icons.settings.codePoint, fontFamily: 'MaterialIcons'),
      trailingIcon: map['trailingIcon'] != null ? IconData(map['trailingIcon'], fontFamily: 'MaterialIcons') : null,
      backgroundColor: Color(map['backgroundColor'] ?? Colors.white.value),
      textColor: Color(map['textColor'] ?? Colors.black.value),
      iconColor: Color(map['iconColor'] ?? Colors.blue.value),
      borderRadius: map['borderRadius'] ?? 0.0,
      showDivider: map['showDivider'] ?? false,
    );
  }
  
  ListTileCustomizationModel copyWith({
    String? title,
    String? subtitle,
    IconData? leadingIcon,
    IconData? trailingIcon,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    double? borderRadius,
    bool? showDivider,
  }) {
    return ListTileCustomizationModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      borderRadius: borderRadius ?? this.borderRadius,
      showDivider: showDivider ?? this.showDivider,
    );
  }
}
