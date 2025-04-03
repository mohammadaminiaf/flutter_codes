import 'package:flutter/material.dart';
import 'package:flutter_codes/components/buttons/round_button.dart';
import 'package:flutter_codes/components/images/circular_image_picker.dart';
import 'package:flutter_codes/components/otp_input/otp_textfield.dart';

import '/models/flutter_category.dart';
import '../components/textfields/password_textfield.dart';

class ComponentModel {
  final String id;
  final String name;
  final String description;
  final FlutterCategory category;
  final Widget widget;
  final String codeFilePath;

  ComponentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.widget,
    required this.codeFilePath,
  });
}

final List<ComponentModel> components = [
  ComponentModel(
    id: '1',
    name: 'Password Text Field',
    description: 'A custom text field for password with visibility toggle',
    category: FlutterCategory.textField,
    widget: PasswordTextfield(),
    codeFilePath: 'password_textfield.txt',
  ),
  ComponentModel(
    id: '2',
    name: 'Round Button',
    description: 'A custom button with rounded corners and lots of options',
    category: FlutterCategory.button,
    widget: RoundButton(text: 'Press Me'),
    codeFilePath: 'round_button.txt',
  ),
  ComponentModel(
    id: '3',
    name: 'OTP Text Field',
    description:
        'A custom otp input field with customizable styles and number of digits',
    category: FlutterCategory.textField,
    widget: OTPTextFeild(),
    codeFilePath: 'otp_textfield.txt',
  ),
  ComponentModel(
    id: '4',
    name: 'Round Image (Picker)',
    description:
        'This widget can be used to display round images for profile and also be used to pick images.',
    category: FlutterCategory.button,
    widget: CircularImagePicker(),
    codeFilePath: 'circular_image_picker.txt',
  ),
];
