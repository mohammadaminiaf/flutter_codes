import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/component_model.dart';
import '/models/customization_models/otp_customization_model.dart';
import '/providers/customization_provider.dart';
import 'common/section_title.dart';
import 'common/color_picker_field.dart';
import 'common/custom_slider.dart';
import 'common/custom_switch.dart';
import 'common/reset_button.dart';

/// Panel for customizing OTP text field components using Riverpod
class OtpTextFieldCustomizationPanelRiverpod extends ConsumerWidget {
  final ComponentModel component;
  final OtpTextFieldCustomizationModel model;

  const OtpTextFieldCustomizationPanelRiverpod({
    super.key, 
    required this.component, 
    required this.model
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(customizationProvider.notifier);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Configuration'),
          CustomSlider(
            label: 'Number of Fields',
            value: model.fieldCount.toDouble(),
            min: 3,
            max: 8,
            onChanged: (value) {
              final updatedModel = model.copyWith(fieldCount: value.toInt());
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Appearance'),
          ColorPickerField(
            label: 'Field Color',
            color: model.fieldColor,
            onColorChanged: (color) {
              final updatedModel = model.copyWith(fieldColor: color);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 8),
          ColorPickerField(
            label: 'Text Color',
            color: model.textColor,
            onColorChanged: (color) {
              final updatedModel = model.copyWith(textColor: color);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Shape'),
          CustomSlider(
            label: 'Field Size',
            value: model.fieldSize,
            min: 30,
            max: 80,
            onChanged: (value) {
              final updatedModel = model.copyWith(fieldSize: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          CustomSlider(
            label: 'Border Radius',
            value: model.borderRadius,
            min: 0,
            max: 20,
            onChanged: (value) {
              final updatedModel = model.copyWith(borderRadius: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Options'),
          CustomSwitch(
            label: 'Secure Entry',
            value: model.obscureText,
            onChanged: (value) {
              final updatedModel = model.copyWith(obscureText: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 24),
          
          ResetButton(
            componentId: component.id,
            onPressed: () {
              notifier.resetComponentCustomization(component.id);
            },
          ),
        ],
      ),
    );
  }
}