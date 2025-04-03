import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/components/otp_input/otp_textfield.dart';
import '/models/component_model.dart';
import '/models/customization_models/otp_customization_model.dart';
import '/providers/component_provider.dart';
import 'common/section_title.dart';
import 'common/color_picker_field.dart';
import 'common/custom_slider.dart';
import 'common/custom_int_slider.dart';
import 'common/reset_button.dart';

/// Panel for customizing OTP text field components
class OtpTextFieldCustomizationPanel extends StatelessWidget {
  final ComponentModel component;
  final OtpTextFieldCustomizationModel model;

  const OtpTextFieldCustomizationPanel({
    super.key, 
    required this.component, 
    required this.model
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ComponentProvider>(context, listen: false);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Layout'),
          CustomIntSlider(
            label: 'Number of Digits',
            value: model.length,
            min: 4,
            max: 8,
            onChanged: (value) {
              final updatedModel = model.copyWith(length: value.toInt());
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          CustomSlider(
            label: 'Spacing',
            value: model.spacing,
            min: 4,
            max: 20,
            onChanged: (value) {
              final updatedModel = model.copyWith(spacing: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Style'),
          DropdownButtonFormField<StyleType>(
            value: model.styleType,
            decoration: const InputDecoration(labelText: 'Style Type'),
            items: StyleType.values.map((type) {
              return DropdownMenuItem<StyleType>(
                value: type,
                child: Text(type.toString().split('.').last),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                final updatedModel = model.copyWith(styleType: value);
                provider.updateComponentCustomization(component.id, updatedModel);
              }
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Border'),
          ColorPickerField(
            label: 'Border Color',
            color: model.borderColor,
            onColorChanged: (color) {
              final updatedModel = model.copyWith(borderColor: color);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 8),
          ColorPickerField(
            label: 'Focus Border Color',
            color: model.focusBorderColor,
            onColorChanged: (color) {
              final updatedModel = model.copyWith(focusBorderColor: color);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 8),
          CustomSlider(
            label: 'Border Width',
            value: model.borderWidth,
            min: 1,
            max: 5,
            onChanged: (value) {
              final updatedModel = model.copyWith(borderWidth: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          ResetButton(componentId: component.id),
        ],
      ),
    );
  }
}