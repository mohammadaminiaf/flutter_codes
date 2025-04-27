import 'package:flutter/material.dart';
import '../../models/component_definition.dart';
import '../../models/flutter_category.dart';
import '../../models/customization_models/common_customization_model.dart';
import '../appbar/appbar.dart';

/// Definitions for app bar components
final List<ComponentDefinition> appBarComponents = [
  ComponentDefinition(
    id: 'custom_appbar',
    name: 'Custom App Bar',
    description: 'A customizable app bar with various options',
    category: FlutterCategory.appBar,
    sourceCodePath: 'appbar/appbar.txt',
    defaultCustomization: CommonCustomizationModel(
      primaryColor: Colors.blue,
      textColor: Colors.white,
    ),
    builder: (customization) {
      final model = customization as CommonCustomizationModel?;
      return TAppBar(
        title: Text('App Bar Title', style: TextStyle(color: model?.textColor)),
        showBackArrow: true,
        centerTitle: false,
      );
    },
    tags: ['appbar', 'navigation', 'header'],
  ),
];
