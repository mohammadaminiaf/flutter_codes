import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_model.dart';

/// A widget to preview a component with customization
class ComponentPreviewRiverpod extends ConsumerWidget {
  final ComponentModel component;

  const ComponentPreviewRiverpod({super.key, required this.component});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create the widget using the component's createWidget method
    // Wrap with ConstrainedBox to ensure proper sizing
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 50, minWidth: 200),
      child: Builder(
        builder: (context) {
          try {
            return component.createWidget();
          } catch (e) {
            debugPrint(
              'Error creating widget for component ${component.id}: $e',
            );
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'Error creating widget',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Component: ${component.name}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    'ID: ${component.id}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Error: $e',
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
