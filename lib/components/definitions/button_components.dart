import 'package:flutter/material.dart';
import '../../models/component_definition.dart';
import '../../models/flutter_category.dart';
import '../../models/customization_models/common_customization_model.dart';
import '../buttons/round_button.dart';

/// Definitions for button components
final List<ComponentDefinition> buttonComponents = [
  ComponentDefinition(
    id: 'buttons_round_button',
    name: 'Round Button',
    description: 'A custom button with rounded corners and lots of options',
    category: FlutterCategory.button,
    sourceCodePath: 'buttons/round_button.txt',
    defaultCustomization: CommonCustomizationModel(
      primaryColor: Colors.blue,
      textColor: Colors.white,
      borderRadius: 28.0,
    ),
    builder: (customization) {
      final model = customization as CommonCustomizationModel?;
      return RoundButton(
        text: 'Press Me',
        backgroundColor: model?.primaryColor,
        textColor: model?.textColor,
        borderRadius: model?.borderRadius ?? 28.0,
        isLoading: false,
        isOutlined: false,
        elevation: 4.0,
        width: 200.0,
        height: 52.0,
        onPressed: () {},
      );
    },
    tags: ['button', 'rounded', 'material'],
  ),
];
