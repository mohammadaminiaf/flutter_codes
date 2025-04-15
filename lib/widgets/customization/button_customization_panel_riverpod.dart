import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '/models/component_model.dart';
import '/models/customization_models/button_customization_model.dart';
import '../../providers/customization_provider/customization_provider.dart';
import 'common/section_title.dart';
import 'common/color_picker_field.dart';
import 'common/custom_slider.dart';
import 'common/custom_switch.dart';
import 'common/reset_button.dart';

/// Panel for customizing button components using Riverpod
class ButtonCustomizationPanelRiverpod extends HookWidget {
  final ComponentModel component;
  final ButtonCustomizationModel model;

  const ButtonCustomizationPanelRiverpod({
    super.key,
    required this.component,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final textController = useTextEditingController(text: model.text);

    return Consumer(
      builder: (context, ref, child) {
        final notifier = ref.read(customizationProvider.notifier);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: 'Button Text'),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Text'),
                controller: textController,
                onChanged: (value) {
                  final updatedModel = model.copyWith(text: value);
                  notifier.updateComponentCustomization(
                    component.id,
                    updatedModel,
                  );
                },
              ),
              const SizedBox(height: 16),

              const SectionTitle(title: 'Appearance'),
              ColorPickerField(
                label: 'Background Color',
                color: model.backgroundColor,
                onColorChanged: (color) {
                  final updatedModel = model.copyWith(backgroundColor: color);
                  notifier.updateComponentCustomization(
                    component.id,
                    updatedModel,
                  );
                },
              ),
              const SizedBox(height: 8),
              ColorPickerField(
                label: 'Text Color',
                color: model.textColor,
                onColorChanged: (color) {
                  final updatedModel = model.copyWith(textColor: color);
                  notifier.updateComponentCustomization(
                    component.id,
                    updatedModel,
                  );
                },
              ),
              const SizedBox(height: 16),

              const SectionTitle(title: 'Text Style'),
              CustomSlider(
                label: 'Font Size',
                value: model.fontSize,
                min: 10,
                max: 100,
                onChanged: (value) {
                  final updatedModel = model.copyWith(fontSize: value);
                  notifier.updateComponentCustomization(
                    component.id,
                    updatedModel,
                  );
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
                  notifier.updateComponentCustomization(
                    component.id,
                    updatedModel,
                  );
                },
              ),
              CustomSlider(
                label: 'Elevation',
                value: model.elevation,
                min: 0,
                max: 20,
                onChanged: (value) {
                  final updatedModel = model.copyWith(elevation: value);
                  notifier.updateComponentCustomization(
                    component.id,
                    updatedModel,
                  );
                },
              ),
              const SizedBox(height: 16),

              const SectionTitle(title: 'Size'),
              CustomSlider(
                label: 'Width',
                value: model.width,
                min: 50,
                max: 300,
                onChanged: (value) {
                  final updatedModel = model.copyWith(width: value);
                  notifier.updateComponentCustomization(
                    component.id,
                    updatedModel,
                  );
                },
              ),
              CustomSlider(
                label: 'Height',
                value: model.height,
                min: 30,
                max: 100,
                onChanged: (value) {
                  final updatedModel = model.copyWith(height: value);
                  notifier.updateComponentCustomization(
                    component.id,
                    updatedModel,
                  );
                },
              ),
              const SizedBox(height: 16),

              const SectionTitle(title: 'Options'),
              CustomSwitch(
                label: 'Loading State',
                value: model.isLoading,
                onChanged: (value) {
                  final updatedModel = model.copyWith(isLoading: value);
                  notifier.updateComponentCustomization(
                    component.id,
                    updatedModel,
                  );
                },
              ),
              const SizedBox(height: 8),
              CustomSwitch(
                label: 'Outlined',
                value: model.isOutlined,
                onChanged: (value) {
                  final updatedModel = model.copyWith(isOutlined: value);
                  notifier.updateComponentCustomization(
                    component.id,
                    updatedModel,
                  );
                },
              ),
              const SizedBox(height: 8),
              CustomSwitch(
                label: 'Enabled',
                value: model.enabled,
                onChanged: (value) {
                  final updatedModel = model.copyWith(enabled: value);
                  notifier.updateComponentCustomization(
                    component.id,
                    updatedModel,
                  );
                },
              ),
              const SizedBox(height: 24),

              ResetButton(componentId: component.id),
            ],
          ),
        );
      },
    );
  }
}
