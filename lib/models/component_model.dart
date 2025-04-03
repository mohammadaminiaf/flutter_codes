import 'package:flutter/material.dart';

import '/components/buttons/round_button.dart';
import '/components/images/circular_image_picker.dart';
import '/components/otp_input/otp_textfield.dart';
import '/components/textfields/password_textfield.dart';
import '/models/customization_models/button_customization_model.dart';
import '/models/customization_models/circular_image_customization_model.dart';
import '/models/customization_models/otp_customization_model.dart';
import '/models/customization_models/textfield_customization_model.dart';
import '/models/flutter_category.dart';
import 'customization_models/customization_model.dart';

class ComponentModel {
  final String id;
  final String name;
  final String description;
  final FlutterCategory category;
  final Widget Function(CustomizationModel?) widgetBuilder;
  final String codeFilePath;
  final CustomizationModel? defaultCustomization;
  CustomizationModel? currentCustomization;

  ComponentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.widgetBuilder,
    required this.codeFilePath,
    this.defaultCustomization,
    this.currentCustomization,
  });
}

final List<ComponentModel> components = [
  ComponentModel(
    id: '1',
    name: 'Password Text Field',
    description: 'A custom text field for password with visibility toggle',
    category: FlutterCategory.textField,
    widgetBuilder: (customization) {
      final model = customization as TextFieldCustomizationModel?;
      return PasswordTextfield(
        labelText: model?.labelText ?? 'Password',
        hintText: model?.hintText ?? 'Enter your password',
        fillColor: model?.fillColor,
        textColor: model?.textColor,
      );
    },
    codeFilePath: 'password_textfield.txt',
    defaultCustomization: TextFieldCustomizationModel(
      labelText: 'Password',
      hintText: 'Enter your password',
      obscureText: true,
    ),
  ),
  ComponentModel(
    id: '2',
    name: 'Round Button',
    description: 'A custom button with rounded corners and lots of options',
    category: FlutterCategory.button,
    widgetBuilder: (customization) {
      final model = customization as ButtonCustomizationModel?;
      return RoundButton(
        text: model?.text ?? 'Press Me',
        backgroundColor: model?.backgroundColor,
        textColor: model?.textColor,
        borderRadius: model?.borderRadius ?? 28.0,
        isLoading: model?.isLoading ?? false,
        isOutlined: model?.isOutlined ?? false,
        elevation: model?.elevation ?? 4.0,
        width: model?.width ?? 200.0,
        height: model?.height ?? 52.0,
      );
    },
    codeFilePath: 'round_button.txt',
    defaultCustomization: ButtonCustomizationModel(
      text: 'Press Me',
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    ),
  ),
  ComponentModel(
    id: '3',
    name: 'OTP Text Field',
    description:
        'A custom otp input field with customizable styles and number of digits',
    category: FlutterCategory.textField,
    widgetBuilder: (customization) {
      final model = customization as OtpTextFieldCustomizationModel?;
      return OTPTextField(
        length: model?.length ?? 4,
        spacing: model?.spacing ?? 8.0,
        styleType: model?.styleType ?? StyleType.bordered,
        borderColor: model?.borderColor ?? Colors.grey,
        focusBorderColor: model?.focusBorderColor ?? Colors.blue,
        borderWidth: model?.borderWidth ?? 2.0,
      );
    },
    codeFilePath: 'otp_textfield.txt',
    defaultCustomization: OtpTextFieldCustomizationModel()
  ),
  ComponentModel(
    id: '4',
    name: 'Circular Image Picker',
    description: 'A circular image picker with customizable styles',
    category: FlutterCategory.image,
    widgetBuilder: (customization) {
      final model = customization as CircularImageCustomizationModel?;
      return CircularImagePicker(
        radius: model?.radius ?? 56.0,
        overlayColor: model?.overlayColor,
        backgroundColor: model?.backgroundColor,
        image: model?.imagePath,
        isNetworkImage: model?.isNetworkImage ?? false,
      );
    },
    codeFilePath: 'circular_image_picker.txt',
    defaultCustomization: CircularImageCustomizationModel(),
  ),
];
