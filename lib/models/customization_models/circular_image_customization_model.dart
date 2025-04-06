import 'package:flutter/material.dart';

import 'customization_model.dart';

/// Customization model for circular image picker components
class CircularImageCustomizationModel extends CustomizationModel {
  double radius;
  double size;
  double borderWidth;
  Color borderColor;
  Color? overlayColor;
  Color backgroundColor;
  bool isNetworkImage;
  String? imagePath;
  bool showEditIcon;
  Color editIconBackgroundColor;
  
  CircularImageCustomizationModel({
    this.radius = 56.0,
    this.size = 100.0,
    this.borderWidth = 2.0,
    this.borderColor = Colors.blue,
    this.overlayColor,
    this.backgroundColor = Colors.white,
    this.isNetworkImage = false,
    this.imagePath,
    this.showEditIcon = true,
    this.editIconBackgroundColor = Colors.blue,
  });
  
  @override
  Map<String, dynamic> toMap() {
    return {
      'radius': radius,
      'size': size,
      'borderWidth': borderWidth,
      'borderColor': borderColor.value,
      'overlayColor': overlayColor?.value,
      'backgroundColor': backgroundColor.value,
      'isNetworkImage': isNetworkImage,
      'imagePath': imagePath,
      'showEditIcon': showEditIcon,
      'editIconBackgroundColor': editIconBackgroundColor.value,
    };
  }
  
  @override
  CustomizationModel fromMap(Map<String, dynamic> map) {
    return CircularImageCustomizationModel(
      radius: map['radius'] ?? 56.0,
      size: map['size'] ?? 100.0,
      borderWidth: map['borderWidth'] ?? 2.0,
      borderColor: map['borderColor'] != null ? Color(map['borderColor']) : Colors.blue,
      overlayColor: map['overlayColor'] != null ? Color(map['overlayColor']) : null,
      backgroundColor: Color(map['backgroundColor'] ?? Colors.white.value),
      isNetworkImage: map['isNetworkImage'] ?? false,
      imagePath: map['imagePath'],
      showEditIcon: map['showEditIcon'] ?? true,
      editIconBackgroundColor: map['editIconBackgroundColor'] != null ? Color(map['editIconBackgroundColor']) : Colors.blue,
    );
  }
  
  CircularImageCustomizationModel copyWith({
    double? radius,
    double? size,
    double? borderWidth,
    Color? borderColor,
    Color? overlayColor,
    Color? backgroundColor,
    bool? isNetworkImage,
    String? imagePath,
    bool? showEditIcon,
    Color? editIconBackgroundColor,
  }) {
    return CircularImageCustomizationModel(
      radius: radius ?? this.radius,
      size: size ?? this.size,
      borderWidth: borderWidth ?? this.borderWidth,
      borderColor: borderColor ?? this.borderColor,
      overlayColor: overlayColor ?? this.overlayColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      isNetworkImage: isNetworkImage ?? this.isNetworkImage,
      imagePath: imagePath ?? this.imagePath,
      showEditIcon: showEditIcon ?? this.showEditIcon,
      editIconBackgroundColor: editIconBackgroundColor ?? this.editIconBackgroundColor,
    );
  }
}