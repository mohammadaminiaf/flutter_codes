import 'package:flutter/material.dart';
import 'flutter_category.dart';
import 'customization_models/customization_model.dart';

/// A class that defines the metadata for a UI component.
/// This is used to register components with the ComponentRegistry.
class ComponentDefinition {
  /// Unique identifier for the component
  final String id;
  
  /// Display name of the component
  final String name;
  
  /// Description of the component
  final String description;
  
  /// Category of the component
  final FlutterCategory category;
  
  /// Path to the source code file
  final String sourceCodePath;
  
  /// Tags for additional categorization and filtering
  final List<String> tags;
  
  /// Default customization model for the component
  final CustomizationModel? defaultCustomization;
  
  /// Function to build the component with customization
  final Widget Function(CustomizationModel?) builder;
  
  const ComponentDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.sourceCodePath,
    required this.builder,
    this.tags = const [],
    this.defaultCustomization,
  });
}
