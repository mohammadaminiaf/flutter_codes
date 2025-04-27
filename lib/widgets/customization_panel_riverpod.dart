import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_model.dart';
import '../models/customization_models/common_customization_model.dart';
import '../providers/customization_provider/customization_provider.dart';

/// A panel for customizing components using Riverpod
class CustomizationPanelRiverpod extends ConsumerWidget {
  final ComponentModel component;

  const CustomizationPanelRiverpod({
    super.key,
    required this.component,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customization = ref.watch(componentCustomizationProvider(component.id));
    final notifier = ref.read(customizationProvider.notifier);
    
    // If no customization is available, show a message
    if (customization == null) {
      return const Center(
        child: Text('No customization options available for this component'),
      );
    }
    
    // For common customization model, show generic controls
    if (customization is CommonCustomizationModel) {
      return _buildCommonCustomizationPanel(context, customization, notifier);
    }
    
    // If we don't know how to customize this component, show a message
    return const Center(
      child: Text('Customization not implemented for this component type'),
    );
  }
  
  Widget _buildCommonCustomizationPanel(
    BuildContext context, 
    CommonCustomizationModel model, 
    CustomizationNotifier notifier
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primary Color
          _buildColorPicker(
            context,
            'Primary Color',
            model.primaryColor,
            (color) {
              final updatedModel = model.copyWith(primaryColor: color);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          
          const SizedBox(height: 16),
          
          // Background Color
          _buildColorPicker(
            context,
            'Background Color',
            model.backgroundColor,
            (color) {
              final updatedModel = model.copyWith(backgroundColor: color);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          
          const SizedBox(height: 16),
          
          // Text Color
          _buildColorPicker(
            context,
            'Text Color',
            model.textColor,
            (color) {
              final updatedModel = model.copyWith(textColor: color);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          
          const SizedBox(height: 16),
          
          // Border Radius
          _buildSlider(
            context,
            'Border Radius',
            model.borderRadius,
            0,
            50,
            (value) {
              final updatedModel = model.copyWith(borderRadius: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          
          const SizedBox(height: 16),
          
          // Has Border
          _buildSwitch(
            context,
            'Show Border',
            model.hasBorder,
            (value) {
              final updatedModel = model.copyWith(hasBorder: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          
          if (model.hasBorder) ...[
            const SizedBox(height: 16),
            
            // Border Color
            _buildColorPicker(
              context,
              'Border Color',
              model.borderColor,
              (color) {
                final updatedModel = model.copyWith(borderColor: color);
                notifier.updateComponentCustomization(component.id, updatedModel);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Border Width
            _buildSlider(
              context,
              'Border Width',
              model.borderWidth,
              0,
              10,
              (value) {
                final updatedModel = model.copyWith(borderWidth: value);
                notifier.updateComponentCustomization(component.id, updatedModel);
              },
            ),
          ],
          
          const SizedBox(height: 16),
          
          // Scale
          _buildSlider(
            context,
            'Scale',
            model.scale,
            0.5,
            2.0,
            (value) {
              final updatedModel = model.copyWith(scale: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          
          const SizedBox(height: 16),
          
          // Enabled
          _buildSwitch(
            context,
            'Enabled',
            model.enabled,
            (value) {
              final updatedModel = model.copyWith(enabled: value);
              notifier.updateComponentCustomization(component.id, updatedModel);
            },
          ),
          
          const SizedBox(height: 16),
          
          // Reset Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                notifier.resetComponentCustomization(component.id);
              },
              child: const Text('Reset to Default'),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildColorPicker(
    BuildContext context,
    String label,
    Color color,
    Function(Color) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _colorOption(Colors.red, color, onChanged),
                  _colorOption(Colors.blue, color, onChanged),
                  _colorOption(Colors.green, color, onChanged),
                  _colorOption(Colors.yellow, color, onChanged),
                  _colorOption(Colors.purple, color, onChanged),
                  _colorOption(Colors.orange, color, onChanged),
                  _colorOption(Colors.teal, color, onChanged),
                  _colorOption(Colors.pink, color, onChanged),
                  _colorOption(Colors.brown, color, onChanged),
                  _colorOption(Colors.grey, color, onChanged),
                  _colorOption(Colors.black, color, onChanged),
                  _colorOption(Colors.white, color, onChanged),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _colorOption(Color color, Color selectedColor, Function(Color) onChanged) {
    final isSelected = color.value == selectedColor.value;
    
    return InkWell(
      onTap: () => onChanged(color),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
  
  Widget _buildSlider(
    BuildContext context,
    String label,
    double value,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleSmall),
            Text(value.toStringAsFixed(1)),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: ((max - min) * 10).toInt(),
          label: value.toStringAsFixed(1),
          onChanged: onChanged,
        ),
      ],
    );
  }
  
  Widget _buildSwitch(
    BuildContext context,
    String label,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
