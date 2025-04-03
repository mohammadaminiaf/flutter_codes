import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/component_model.dart';
import '/models/customization_models/textfield_customization_model.dart';
import '/providers/component_provider.dart';
import 'common/section_title.dart';
import 'common/color_picker_field.dart';
import 'common/custom_slider.dart';
import 'common/custom_switch.dart';
import 'common/reset_button.dart';

/// Panel for customizing text field components
class TextFieldCustomizationPanel extends StatelessWidget {
  final ComponentModel component;
  final TextFieldCustomizationModel model;

  const TextFieldCustomizationPanel({
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
          const SectionTitle(title: 'Text'),
          TextField(
            decoration: const InputDecoration(labelText: 'Label Text'),
            controller: TextEditingController(text: model.labelText),
            onChanged: (value) {
              final updatedModel = model.copyWith(labelText: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(labelText: 'Hint Text'),
            controller: TextEditingController(text: model.hintText),
            onChanged: (value) {
              final updatedModel = model.copyWith(hintText: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Appearance'),
          ColorPickerField(
            label: 'Fill Color',
            color: model.fillColor,
            onColorChanged: (color) {
              final updatedModel = model.copyWith(fillColor: color);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 8),
          ColorPickerField(
            label: 'Text Color',
            color: model.textColor,
            onColorChanged: (color) {
              final updatedModel = model.copyWith(textColor: color);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Shape'),
          CustomSlider(
            label: 'Border Radius',
            value: model.borderRadius,
            min: 0,
            max: 30,
            onChanged: (value) {
              final updatedModel = model.copyWith(borderRadius: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Options'),
          CustomSwitch(
            label: 'Has Border',
            value: model.hasBorder,
            onChanged: (value) {
              final updatedModel = model.copyWith(hasBorder: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          CustomSwitch(
            label: 'Password Field',
            value: model.obscureText,
            onChanged: (value) {
              final updatedModel = model.copyWith(obscureText: value);
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