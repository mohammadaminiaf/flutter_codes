import 'package:flutter/material.dart';
import '../../models/component_definition.dart';
import '../../models/flutter_category.dart';
import '../../models/customization_models/common_customization_model.dart';
import '../textfields/password_textfield.dart';
import '../otp_input/otp_textfield.dart';

/// Definitions for text field components
final List<ComponentDefinition> textFieldComponents = [
  ComponentDefinition(
    id: 'password_textfield',
    name: 'Password Text Field',
    description: 'A custom text field for password with visibility toggle',
    category: FlutterCategory.textField,
    sourceCodePath: 'textfields/password_textfield.txt',
    defaultCustomization: CommonCustomizationModel(
      textColor: Colors.black,
      backgroundColor: Colors.white,
    ),
    builder: (customization) {
      final model = customization as CommonCustomizationModel?;
      return PasswordTextfield(
        labelText: 'Password',
        hintText: 'Enter your password',
        fillColor: model?.backgroundColor,
        textColor: model?.textColor,
      );
    },
    tags: ['textfield', 'password', 'input', 'form'],
  ),
  
  ComponentDefinition(
    id: 'otp_textfield',
    name: 'OTP Text Field',
    description: 'A custom OTP input field with customizable styles and number of digits',
    category: FlutterCategory.textField,
    sourceCodePath: 'textfields/otp_textfield.txt',
    defaultCustomization: CommonCustomizationModel(
      primaryColor: Colors.blue,
      borderColor: Colors.grey,
      borderWidth: 2.0,
    ),
    builder: (customization) {
      final model = customization as CommonCustomizationModel?;
      return OTPTextField(
        length: 4,
        spacing: 8.0,
        styleType: StyleType.bordered,
        borderColor: model?.borderColor ?? Colors.grey,
        focusBorderColor: model?.primaryColor ?? Colors.blue,
        borderWidth: model?.borderWidth ?? 2.0,
      );
    },
    tags: ['textfield', 'otp', 'input', 'form'],
  ),
];
