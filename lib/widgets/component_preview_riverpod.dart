import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_model.dart';
import '../providers/customization_provider/customization_provider.dart';

class ComponentPreviewRiverpod extends ConsumerWidget {
  final ComponentModel component;

  const ComponentPreviewRiverpod({super.key, required this.component});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the Riverpod provider to get the current customization for this component
    final customization = ref.watch(componentCustomizationProvider(component.id));
    
    // Use the component's widgetBuilder function to create the widget with customization
    return component.widgetBuilder(customization);
  }
}