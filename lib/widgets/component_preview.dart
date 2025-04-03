import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/component_model.dart';
import '../providers/component_provider.dart';

class ComponentPreview extends StatelessWidget {
  final ComponentModel component;

  const ComponentPreview({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    final componentProvider = Provider.of<ComponentProvider>(context);
    final customization = componentProvider.getComponentCustomization(component.id);
    
    // Use the component's widgetBuilder function to create the widget with customization
    return component.widgetBuilder(customization);
  }
}