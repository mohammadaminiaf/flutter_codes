import 'dart:io';

import 'package:flutter/foundation.dart';

import '../components/definitions/appbar_components.dart';
import '../components/definitions/button_components.dart';
import '../components/definitions/carousel_components.dart';
import '../components/definitions/image_components.dart';
import '../models/component_definition.dart';
import '../models/component_model.dart';
import '../registry/component_registry.dart';

/// A service for registering component definitions
class ComponentDefinitionRegistryService {
  ComponentDefinitionRegistryService._(); // Private constructor to prevent instantiation

  /// Register all component definitions
  static void registerAllDefinitions() {
    debugPrint('Registering component definitions...');

    try {
      // Register component definitions from imported files
      _registerImportedDefinitions();

      // Register component definitions from the file system
      _registerDefinitionsFromFileSystem();

      debugPrint('Component definitions registered successfully');
    } catch (e) {
      debugPrint('Error registering component definitions: $e');
    }
  }

  /// Register component definitions from imported files
  static void _registerImportedDefinitions() {
    debugPrint('Registering component definitions from imported files...');

    // Register app bar components
    for (final definition in appBarComponents) {
      _registerComponentDefinition(definition);
    }

    // Register button components
    for (final definition in buttonComponents) {
      _registerComponentDefinition(definition);
    }

    // Register carousel components
    for (final definition in carouselComponents) {
      _registerComponentDefinition(definition);
    }

    // Register image components
    for (final definition in imageComponents) {
      _registerComponentDefinition(definition);
    }

    // Add more component types here as needed
  }

  /// Register component definitions from the file system
  static void _registerDefinitionsFromFileSystem() {
    debugPrint('Registering component definitions from file system...');

    final definitionsDir = Directory('lib/components/definitions');
    if (!definitionsDir.existsSync()) {
      debugPrint('Definitions directory not found');
      return;
    }

    // Get all Dart files in the definitions directory
    final definitionFiles =
        definitionsDir
            .listSync()
            .whereType<File>()
            .where((file) => file.path.endsWith('.dart'))
            .toList();

    debugPrint('Found ${definitionFiles.length} definition files');

    // Process each definition file
    // Note: This is a placeholder for future implementation
    // In a real implementation, we would dynamically load these files
    debugPrint('Dynamic loading of definition files is not yet implemented');
  }

  /// Register a component definition
  static void _registerComponentDefinition(ComponentDefinition definition) {
    // Log the actual ID being registered
    debugPrint('Registering component definition: ${definition.id}');

    // Create a component model from the definition
    final component = ComponentModel(
      id: definition.id,
      name: definition.name,
      description: definition.description,
      category: definition.category,
      widgetBuilder: definition.builder,
      codeFilePath: definition.sourceCodePath,
      defaultCustomization: definition.defaultCustomization,
    );

    // Register the component
    ComponentRegistry.register(component);
  }
}
