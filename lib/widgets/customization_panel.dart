import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/component_model.dart';
import 'customization/customization_panel.dart';

/// A wrapper class that delegates to the Riverpod implementation in the customization directory
class CustomizationPanelRiverpod extends ConsumerWidget {
  final ComponentModel component;

  const CustomizationPanelRiverpod({super.key, required this.component});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Delegate to the Riverpod implementation in the customization directory
    return CustomizationPanel(component: component);
  }
}
