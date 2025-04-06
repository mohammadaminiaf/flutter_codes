import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/component_model.dart';
import '/models/customization_models/button_customization_model.dart';
import '/models/customization_models/circular_image_customization_model.dart';
import '/models/customization_models/customization_model.dart';
import '/models/customization_models/otp_customization_model.dart';
import '/models/customization_models/textfield_customization_model.dart';
import '/providers/customization_provider.dart';
import 'button_customization_panel_riverpod.dart';
import 'textfield_customization_panel_riverpod.dart';
import 'otp_textfield_customization_panel_riverpod.dart';
import 'circular_image_customization_panel_riverpod.dart';

/// Main customization panel that delegates to the appropriate panel based on component type
class RiverpodCustomizationPanel extends ConsumerWidget {
  final ComponentModel component;

  const RiverpodCustomizationPanel({super.key, required this.component});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customization = ref.watch(componentCustomizationProvider(component.id));

    // Determine which customization panel to show based on the component's customization model type
    if (customization is ButtonCustomizationModel) {
      return ButtonCustomizationPanelRiverpod(
        component: component,
        model: customization as ButtonCustomizationModel,
      );
    } else if (customization is TextFieldCustomizationModel) {
      return TextFieldCustomizationPanelRiverpod(
        component: component,
        model: customization as TextFieldCustomizationModel,
      );
    } else if (customization is OtpTextFieldCustomizationModel) {
      return OtpTextFieldCustomizationPanelRiverpod(
        component: component,
        model: customization as OtpTextFieldCustomizationModel,
      );
    } else if (customization is CircularImageCustomizationModel) {
      return CircularImageCustomizationPanelRiverpod(
        component: component,
        model: customization as CircularImageCustomizationModel,
      );
    } else {
      return const Center(child: Text('No customization options available'));
    }
  }
}