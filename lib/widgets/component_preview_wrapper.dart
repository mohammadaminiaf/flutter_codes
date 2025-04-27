import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_model.dart';
import '../models/flutter_category.dart';

/// A wrapper widget that provides proper constraints for component previews
class ComponentPreviewWrapper extends ConsumerWidget {
  final ComponentModel component;

  const ComponentPreviewWrapper({super.key, required this.component});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create a widget with appropriate constraints based on the component type
    return _buildConstrainedPreview(context, component);
  }

  Widget _buildConstrainedPreview(
    BuildContext context,
    ComponentModel component,
  ) {
    // Different constraints based on component category
    switch (component.category) {
      case FlutterCategory.appBar:
        return SizedBox(
          width: 300,
          height: 80,
          child: Center(
            child: Text(
              'AppBar: ${component.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );

      case FlutterCategory.bottomNavigationBar:
        return SizedBox(
          width: 300,
          height: 200,
          child: Scaffold(
            body: Container(), // Empty body
            bottomNavigationBar: component.createWidget(),
          ),
        );

      case FlutterCategory.drawer:
        return SizedBox(
          width: 250,
          height: 300,
          child: component.createWidget(),
        );

      case FlutterCategory.dialog:
        return SizedBox(
          width: 300,
          height: 200,
          child: Center(child: Material(child: component.createWidget())),
        );

      // Default case for most components
      default:
        return SizedBox(
          width: 300,
          height: 200,
          child: Center(child: component.createWidget()),
        );
    }
  }
}
