import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/component_model.dart';
import '/models/customization_models/button_customization_model.dart';
import '/models/customization_models/circular_image_customization_model.dart';
import '/models/customization_models/customization_model.dart';
import '/models/customization_models/otp_customization_model.dart';
import '/models/customization_models/textfield_customization_model.dart';
import '/providers/component_provider.dart';
import 'button_customization_panel.dart';
import 'textfield_customization_panel.dart';
import 'otp_textfield_customization_panel.dart';
import 'circular_image_customization_panel.dart';

/// Main customization panel that delegates to the appropriate panel based on component type
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
    // Determine which customization panel to show based on the component's customization model type
    if (customization is ButtonCustomizationModel) {
      return ButtonCustomizationPanel(
        component: widget.component,
        model: customization as ButtonCustomizationModel,
      );
    } else if (customization is TextFieldCustomizationModel) {
      return TextFieldCustomizationPanel(
        component: widget.component,
        model: customization as TextFieldCustomizationModel,
      );
    } else if (customization is OtpTextFieldCustomizationModel) {
      return OtpTextFieldCustomizationPanel(
        component: widget.component,
        model: customization as OtpTextFieldCustomizationModel,
      );
    } else if (customization is CircularImageCustomizationModel) {
      return CircularImageCustomizationPanel(
        component: widget.component,
        model: customization as CircularImageCustomizationModel,
      );
    } else {
      return const Center(child: Text('No customization options available'));
    }
  }
}