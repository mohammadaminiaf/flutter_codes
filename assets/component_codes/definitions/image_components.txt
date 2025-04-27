import 'package:flutter/material.dart';
import '../../models/component_definition.dart';
import '../../models/flutter_category.dart';
import '../../models/customization_models/common_customization_model.dart';
import '../images/circular_image_picker.dart';

/// Definitions for image components
final List<ComponentDefinition> imageComponents = [
  ComponentDefinition(
    id: 'images_circular_image_picker',
    name: 'Circular Image Picker',
    description: 'A circular image picker with customizable styles',
    category: FlutterCategory.image,
    sourceCodePath: 'images/circular_image_picker.txt',
    defaultCustomization: CommonCustomizationModel(
      backgroundColor: Colors.white,
      primaryColor: Colors.blue,
    ),
    builder: (customization) {
      final model = customization as CommonCustomizationModel?;
      return CircularImagePicker(
        radius: 100.0,
        overlayColor:
            model?.primaryColor != null
                ? model!.primaryColor.withAlpha(77)
                : null,
        backgroundColor: model?.backgroundColor,
        showEditIcon: model?.hasBorder ?? false,
      );
    },
    tags: ['image', 'picker', 'circular', 'avatar'],
  ),
];
