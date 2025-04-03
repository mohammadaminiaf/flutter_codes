import 'package:flutter/material.dart';

import '/models/component_model.dart';
import 'customization/customization_panel.dart' as custom_impl;

/// A wrapper class that delegates to the implementation in the customization directory
class CustomizationPanel extends StatefulWidget {
  final ComponentModel component;

  const CustomizationPanel({super.key, required this.component});

  @override
  State<CustomizationPanel> createState() => _CustomizationPanelState();
}

class _CustomizationPanelState extends State<CustomizationPanel> {
  @override
  Widget build(BuildContext context) {
    // Delegate to the implementation in the customization directory
    return custom_impl.CustomizationPanel(component: widget.component);
  }
}