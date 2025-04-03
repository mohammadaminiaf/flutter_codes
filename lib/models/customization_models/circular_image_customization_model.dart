import 'package:flutter/material.dart';

import 'customization_model.dart';

/// Customization model for circular image picker components
class CircularImageCustomizationModel extends CustomizationModel {
  double radius;
  Color? overlayColor;
  Color backgroundColor;
  bool isNetworkImage;
  String? imagePath;
  
  CircularImageCustomizationModel({
    this.radius = 56.0,
    this.overlayColor,
    this.backgroundColor = Colors.white,
    this.isNetworkImage = false,
    this.imagePath,
  });
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'radius': radius,
      'overlayColor': overlayColor?.value,
      'backgroundColor': backgroundColor.value,
      'isNetworkImage': isNetworkImage,
      'imagePath': imagePath,
    };
  }
  
  @override
  CustomizationModel fromMap(Map<String, dynamic> map) {
    return CircularImageCustomizationModel(
      radius: map['radius'] ?? 56.0,
      overlayColor: map['overlayColor'] != null ? Color(map['overlayColor']) : null,
      backgroundColor: Color(map['backgroundColor'] ?? Colors.white.value),
      isNetworkImage: map['isNetworkImage'] ?? false,
      imagePath: map['imagePath'],
    );
  }
  
  CircularImageCustomizationModel copyWith({
    double? radius,
    Color? overlayColor,
    Color? backgroundColor,
    bool? isNetworkImage,
    String? imagePath,
  }) {
    return CircularImageCustomizationModel(
      radius: radius ?? this.radius,
      overlayColor: overlayColor ?? this.overlayColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      isNetworkImage: isNetworkImage ?? this.isNetworkImage,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}