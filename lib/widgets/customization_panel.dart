import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/customization_models/button_customization_model.dart';
import '/models/customization_models/circular_image_customization_model.dart';
import '/models/customization_models/otp_customization_model.dart';
import '/models/customization_models/textfield_customization_model.dart';
import '../components/otp_input/otp_textfield.dart';
import '../models/component_model.dart';
import '../models/customization_models/customization_model.dart';
import '../providers/component_provider.dart';

class CustomizationPanel extends StatefulWidget {
  final ComponentModel component;

  const CustomizationPanel({super.key, required this.component});

  @override
  State<CustomizationPanel> createState() => _CustomizationPanelState();
}

class _CustomizationPanelState extends State<CustomizationPanel> {
  late CustomizationModel? customization;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ComponentProvider>(context, listen: false);
    customization = provider.getComponentCustomization(widget.component.id);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ComponentProvider>(context, listen: false);

    // Determine which customization panel to show based on the component's customization model type
    if (customization is ButtonCustomizationModel) {
      return _buildButtonCustomizationPanel(provider, customization as ButtonCustomizationModel);
    } else if (customization is TextFieldCustomizationModel) {
      return _buildTextFieldCustomizationPanel(provider, customization as TextFieldCustomizationModel);
    } else if (customization is OtpTextFieldCustomizationModel) {
      return _buildOtpTextFieldCustomizationPanel(provider, customization as OtpTextFieldCustomizationModel);
    } else if (customization is CircularImageCustomizationModel) {
      return _buildImagePickerCustomizationPanel(provider, customization as CircularImageCustomizationModel);
    } else {
      return const Center(child: Text('No customization options available'));
    }
  }

  Widget _buildButtonCustomizationPanel(ComponentProvider provider, ButtonCustomizationModel model) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Button Text'),
          TextField(
            decoration: const InputDecoration(labelText: 'Text'),
            controller: TextEditingController(text: model.text),
            onChanged: (value) {
              final updatedModel = model.copyWith(text: value);
              provider.updateComponentCustomization(widget.component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          _buildSectionTitle('Appearance'),
          _buildColorPicker('Background Color', model.backgroundColor, (color) {
            final updatedModel = model.copyWith(backgroundColor: color);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 8),
          _buildColorPicker('Text Color', model.textColor, (color) {
            final updatedModel = model.copyWith(textColor: color);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildSectionTitle('Shape'),
          _buildSlider('Border Radius', model.borderRadius, 0, 50, (value) {
            final updatedModel = model.copyWith(borderRadius: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildSectionTitle('Size'),
          _buildSlider('Width', model.width, 100, 300, (value) {
            final updatedModel = model.copyWith(width: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          _buildSlider('Height', model.height, 30, 80, (value) {
            final updatedModel = model.copyWith(height: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildSectionTitle('Style'),
          _buildSwitch('Outlined', model.isOutlined, (value) {
            final updatedModel = model.copyWith(isOutlined: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          _buildSlider('Elevation', model.elevation, 0, 10, (value) {
            final updatedModel = model.copyWith(elevation: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildSectionTitle('State'),
          _buildSwitch('Loading', model.isLoading, (value) {
            final updatedModel = model.copyWith(isLoading: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildResetButton(provider),
        ],
      ),
    );
  }

  Widget _buildTextFieldCustomizationPanel(ComponentProvider provider, TextFieldCustomizationModel model) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Text'),
          TextField(
            decoration: const InputDecoration(labelText: 'Label Text'),
            controller: TextEditingController(text: model.labelText),
            onChanged: (value) {
              final updatedModel = model.copyWith(labelText: value);
              provider.updateComponentCustomization(widget.component.id, updatedModel);
            },
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(labelText: 'Hint Text'),
            controller: TextEditingController(text: model.hintText),
            onChanged: (value) {
              final updatedModel = model.copyWith(hintText: value);
              provider.updateComponentCustomization(widget.component.id, updatedModel);
            },
          ),
          const SizedBox(height: 16),
          
          _buildSectionTitle('Appearance'),
          _buildColorPicker('Fill Color', model.fillColor, (color) {
            final updatedModel = model.copyWith(fillColor: color);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 8),
          _buildColorPicker('Text Color', model.textColor, (color) {
            final updatedModel = model.copyWith(textColor: color);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildSectionTitle('Shape'),
          _buildSlider('Border Radius', model.borderRadius, 0, 30, (value) {
            final updatedModel = model.copyWith(borderRadius: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildSectionTitle('Options'),
          _buildSwitch('Has Border', model.hasBorder, (value) {
            final updatedModel = model.copyWith(hasBorder: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          _buildSwitch('Password Field', model.obscureText, (value) {
            final updatedModel = model.copyWith(obscureText: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildResetButton(provider),
        ],
      ),
    );
  }

  Widget _buildOtpTextFieldCustomizationPanel(ComponentProvider provider, OtpTextFieldCustomizationModel model) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Layout'),
          _buildIntSlider('Number of Digits', model.length, 4, 8, (value) {
            final updatedModel = model.copyWith(length: value.toInt());
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          _buildSlider('Spacing', model.spacing, 4, 20, (value) {
            final updatedModel = model.copyWith(spacing: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildSectionTitle('Style'),
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
                provider.updateComponentCustomization(widget.component.id, updatedModel);
              }
            },
          ),
          const SizedBox(height: 16),
          
          _buildSectionTitle('Border'),
          _buildColorPicker('Border Color', model.borderColor, (color) {
            final updatedModel = model.copyWith(borderColor: color);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 8),
          _buildColorPicker('Focus Border Color', model.focusBorderColor, (color) {
            final updatedModel = model.copyWith(focusBorderColor: color);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 8),
          _buildSlider('Border Width', model.borderWidth, 1, 5, (value) {
            final updatedModel = model.copyWith(borderWidth: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildResetButton(provider),
        ],
      ),
    );
  }

  Widget _buildImagePickerCustomizationPanel(ComponentProvider provider, CircularImageCustomizationModel model) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Size'),
          _buildSlider('Radius', model.radius, 30, 100, (value) {
            final updatedModel = model.copyWith(radius: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildSectionTitle('Colors'),
          _buildColorPicker('Background Color', model.backgroundColor, (color) {
            final updatedModel = model.copyWith(backgroundColor: color);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 8),
          _buildColorPicker('Overlay Color', model.overlayColor ?? Colors.transparent, (color) {
            final updatedModel = model.copyWith(overlayColor: color);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildSectionTitle('Image'),
          TextField(
            decoration: const InputDecoration(labelText: 'Image Path (optional)'),
            controller: TextEditingController(text: model.imagePath),
            onChanged: (value) {
              final updatedModel = model.copyWith(imagePath: value.isEmpty ? null : value);
              provider.updateComponentCustomization(widget.component.id, updatedModel);
            },
          ),
          const SizedBox(height: 8),
          _buildSwitch('Network Image', model.isNetworkImage, (value) {
            final updatedModel = model.copyWith(isNetworkImage: value);
            provider.updateComponentCustomization(widget.component.id, updatedModel);
          }),
          const SizedBox(height: 16),
          
          _buildResetButton(provider),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildColorPicker(String label, Color color, Function(Color) onColorChanged) {
    return Row(
      children: [
        Text(label),
        const Spacer(),
        GestureDetector(
          onTap: () {
            _showColorPicker(color, onColorChanged);
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }

  void _showColorPicker(Color initialColor, Function(Color) onColorChanged) {
    showDialog(
      context: context,
      builder: (context) {
        Color selectedColor = initialColor;
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: initialColor,
              onColorChanged: (color) {
                selectedColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onColorChanged(selectedColor);
                Navigator.of(context).pop();
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
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

  Widget _buildIntSlider(String label, int value, int min, int max, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value.toString()),
          ],
        ),
        Slider(
          value: value.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: max - min,
          label: value.toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSwitch(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildResetButton(ComponentProvider provider) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          provider.resetComponentCustomization(widget.component.id);
        },
        icon: const Icon(Icons.refresh),
        label: const Text('Reset to Default'),
      ),
    );
  }
}

// Simple color picker widget
class ColorPicker extends StatefulWidget {
  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPicker({
    super.key,
    required this.pickerColor,
    required this.onColorChanged,
  });

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.pickerColor;
  }

  @override
  Widget build(BuildContext context) {
    // A simple color grid
    final List<Color> colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      Colors.black,
      Colors.white,
    ];

    return SizedBox(
      width: 300,
      height: 300,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                currentColor = colors[index];
                widget.onColorChanged(currentColor);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: colors[index],
                border: Border.all(
                  color: currentColor == colors[index] ? Colors.black : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        },
      ),
    );
  }
}