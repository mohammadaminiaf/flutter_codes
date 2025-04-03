import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/component_model.dart';
import '/models/customization_models/button_customization_model.dart';
import '/providers/component_provider.dart';
import 'common/section_title.dart';
import 'common/color_picker_field.dart';
import 'common/custom_slider.dart';
import 'common/custom_switch.dart';
import 'common/reset_button.dart';

/// Panel for customizing button components
class ButtonCustomizationPanel extends StatelessWidget {
  final ComponentModel component;
  final ButtonCustomizationModel model;

  const ButtonCustomizationPanel({
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
          const SectionTitle(title: 'Button Text'),
          TextField(
            decoration: const InputDecoration(labelText: 'Text'),
            controller: TextEditingController(text: model.text),
            onChanged: (value) {
              final updatedModel = model.copyWith(text: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Appearance'),
          ColorPickerField(
            label: 'Background Color',
            color: model.backgroundColor,
            onColorChanged: (color) {
              final updatedModel = model.copyWith(backgroundColor: color);
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
            max: 50,
            onChanged: (value) {
              final updatedModel = model.copyWith(borderRadius: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Size'),
          CustomSlider(
            label: 'Width',
            value: model.width,
            min: 100,
            max: 300,
            onChanged: (value) {
              final updatedModel = model.copyWith(width: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          CustomSlider(
            label: 'Height',
            value: model.height,
            min: 30,
            max: 80,
            onChanged: (value) {
              final updatedModel = model.copyWith(height: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Style'),
          CustomSwitch(
            label: 'Outlined',
            value: model.isOutlined,
            onChanged: (value) {
              final updatedModel = model.copyWith(isOutlined: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          CustomSlider(
            label: 'Elevation',
            value: model.elevation,
            min: 0,
            max: 10,
            onChanged: (value) {
              final updatedModel = model.copyWith(elevation: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'State'),
          CustomSwitch(
            label: 'Loading',
            value: model.isLoading,
            onChanged: (value) {
              final updatedModel = model.copyWith(isLoading: value);
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