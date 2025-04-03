import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/component_model.dart';
import '/models/customization_models/circular_image_customization_model.dart';
import '/providers/component_provider.dart';
import 'common/section_title.dart';
import 'common/color_picker_field.dart';
import 'common/custom_slider.dart';
import 'common/custom_switch.dart';
import 'common/reset_button.dart';

/// Panel for customizing circular image picker components
class CircularImageCustomizationPanel extends StatelessWidget {
  final ComponentModel component;
  final CircularImageCustomizationModel model;

  const CircularImageCustomizationPanel({
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
          const SectionTitle(title: 'Size'),
          CustomSlider(
            label: 'Radius',
            value: model.radius,
            min: 30,
            max: 100,
            onChanged: (value) {
              final updatedModel = model.copyWith(radius: value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Colors'),
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
            label: 'Overlay Color',
            color: model.overlayColor ?? Colors.transparent,
            onColorChanged: (color) {
              final updatedModel = model.copyWith(overlayColor: color);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          const SectionTitle(title: 'Image'),
          TextField(
            decoration: const InputDecoration(labelText: 'Image Path (optional)'),
            controller: TextEditingController(text: model.imagePath),
            onChanged: (value) {
              final updatedModel = model.copyWith(imagePath: value.isEmpty ? null : value);
              provider.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          const SizedBox(height: 8),
          CustomSwitch(
            label: 'Network Image',
            value: model.isNetworkImage,
            onChanged: (value) {
              final updatedModel = model.copyWith(isNetworkImage: value);
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