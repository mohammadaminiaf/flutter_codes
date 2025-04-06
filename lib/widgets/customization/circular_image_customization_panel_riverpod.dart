import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/component_model.dart';
import '/models/customization_models/circular_image_customization_model.dart';
import '/providers/customization_provider.dart';
import 'common/section_title.dart';
import 'common/color_picker_field.dart';
import 'common/custom_slider.dart';
import 'common/custom_switch.dart';
import 'common/reset_button.dart';

/// Panel for customizing circular image components using Riverpod
class CircularImageCustomizationPanelRiverpod extends ConsumerWidget {
  final ComponentModel component;
  final CircularImageCustomizationModel model;

  const CircularImageCustomizationPanelRiverpod({
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
          const SectionTitle(title: 'Size'),
          CustomSlider(
            label: 'Image Size',
            value: model.size,
            min: 50,
            max: 200,
            onChanged: (value) {
              final updatedModel = model.copyWith(size: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Border'),
          CustomSlider(
            label: 'Border Width',
            value: model.borderWidth,
            min: 0,
            max: 10,
            onChanged: (value) {
              final updatedModel = model.copyWith(borderWidth: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 8),
          ColorPickerField(
            label: 'Border Color',
            color: model.borderColor,
            onColorChanged: (color) {
              final updatedModel = model.copyWith(borderColor: color);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Appearance'),
          CustomSwitch(
            label: 'Show Edit Icon',
            value: model.showEditIcon,
            onChanged: (value) {
              final updatedModel = model.copyWith(showEditIcon: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 8),
          ColorPickerField(
            label: 'Edit Icon Background',
            color: model.editIconBackgroundColor,
            onColorChanged: (color) {
              final updatedModel = model.copyWith(editIconBackgroundColor: color);
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