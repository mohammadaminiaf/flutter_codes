import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/component_model.dart';
import '/models/customization_models/textfield_customization_model.dart';
import '../../providers/customization_provider/customization_provider.dart';
import 'common/section_title.dart';
import 'common/color_picker_field.dart';
import 'common/custom_slider.dart';
import 'common/custom_switch.dart';
import 'common/reset_button.dart';

/// Panel for customizing text field components using Riverpod
class TextFieldCustomizationPanelRiverpod extends ConsumerWidget {
  final ComponentModel component;
  final TextFieldCustomizationModel model;

  const TextFieldCustomizationPanelRiverpod({
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
          const SectionTitle(title: 'Text'),
          TextField(
            decoration: const InputDecoration(labelText: 'Label Text'),
            controller: TextEditingController(text: model.labelText),
            onChanged: (value) {
              final updatedModel = model.copyWith(labelText: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(labelText: 'Hint Text'),
            controller: TextEditingController(text: model.hintText),
            onChanged: (value) {
              final updatedModel = model.copyWith(hintText: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Appearance'),
          ColorPickerField(
            label: 'Fill Color',
            color: model.fillColor,
            onColorChanged: (color) {
              final updatedModel = model.copyWith(fillColor: color);
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
            label: 'Border Radius',
            value: model.borderRadius,
            min: 0,
            max: 30,
            onChanged: (value) {
              final updatedModel = model.copyWith(borderRadius: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Options'),
          CustomSwitch(
            label: 'Has Border',
            value: model.hasBorder,
            onChanged: (value) {
              final updatedModel = model.copyWith(hasBorder: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          CustomSwitch(
            label: 'Password Field',
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