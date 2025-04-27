import 'package:flutter/material.dart';
import 'flutter_category.dart';
import 'customization_models/customization_model.dart';

/// Model class for UI components.
/// This class is used to represent a component in the application.
class ComponentModel {
  /// Unique identifier for the component
  final String id;

  /// Display name of the component
  final String name;

  /// Description of the component
  final String description;

  /// Category of the component
  final FlutterCategory category;

  /// Function to build the component with customization
  final Widget Function(CustomizationModel?) widgetBuilder;

  /// Path to the source code file
  final String codeFilePath;

  /// Tags for additional categorization and filtering
  final List<String> tags;

  /// Default customization model for the component
  final CustomizationModel? defaultCustomization;

  /// Current customization model for the component
  CustomizationModel? currentCustomization;

  ComponentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.widgetBuilder,
    required this.codeFilePath,
    this.tags = const [],
    this.defaultCustomization,
    this.currentCustomization,
  });

  /// Create a widget for this component
  Widget createWidget() {
    try {
      debugPrint('Creating widget for component: $name (ID: $id)');

      // Use the widgetBuilder function with the current customization
      // This allows for dynamic widget creation based on customization
      final widget = widgetBuilder(
        currentCustomization ?? defaultCustomization,
      );

      debugPrint('Successfully created widget for component: $name');
      return widget;
    } catch (e) {
      debugPrint('Error creating widget for component $name (ID: $id): $e');
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 32),
            const SizedBox(height: 8),
            Text(
              'Error creating widget for $name',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Error: $e',
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
          ],
        ),
      );
    }
  }
}
