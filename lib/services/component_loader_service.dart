import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../components/definitions/appbar_components.dart';
import '../components/definitions/button_components.dart';
import '../components/definitions/carousel_components.dart';
import '../components/definitions/image_components.dart';
import '../models/component_definition.dart';
import '../models/component_model.dart';
import '../models/customization_models/common_customization_model.dart';
import '../models/flutter_category.dart';
import '../registry/component_registry.dart';
import '../widgets/placeholder_widget.dart';

/// A service for loading components from various sources
class ComponentLoaderService {
  ComponentLoaderService._(); // Private constructor to prevent instantiation

  /// Load all components from all sources
  static Future<void> loadAllComponents() async {
    debugPrint('Loading all components...');

    // Clear any existing components
    ComponentRegistry.clear();

    try {
      // Create a map to track which components have been registered
      final Map<String, bool> registeredComponents = {};

      // First, load components from definition files
      await _loadComponentsFromDefinitions(registeredComponents);

      // Then, load components from the file system that don't have definitions
      await _loadComponentsFromFileSystem(registeredComponents);

      debugPrint(
        'Total components loaded: ${ComponentRegistry.getAllComponents().length}',
      );
    } catch (e) {
      debugPrint('Error loading components: $e');
    }
  }

  /// Load components from definition files
  static Future<void> _loadComponentsFromDefinitions(
    Map<String, bool> registeredComponents,
  ) async {
    debugPrint('Loading components from definition files...');

    // Process carousel components
    for (final definition in carouselComponents) {
      _registerComponentDefinition(definition, registeredComponents);
    }

    // Process button components
    for (final definition in buttonComponents) {
      _registerComponentDefinition(definition, registeredComponents);
    }

    // Process image components
    for (final definition in imageComponents) {
      _registerComponentDefinition(definition, registeredComponents);
    }

    // Process appbar components
    for (final definition in appBarComponents) {
      _registerComponentDefinition(definition, registeredComponents);
    }
  }

  /// Register a component definition
  static void _registerComponentDefinition(
    ComponentDefinition definition,
    Map<String, bool> registeredComponents,
  ) {
    final id = definition.id;
    debugPrint('Registering component definition: $id');

    // Create a component model from the definition
    final component = ComponentModel(
      id: id,
      name: definition.name,
      description: definition.description,
      category: definition.category,
      widgetBuilder: definition.builder,
      codeFilePath: definition.sourceCodePath,
      defaultCustomization: definition.defaultCustomization,
    );

    // Register the component
    ComponentRegistry.register(component);
    registeredComponents[id] = true;
  }

  /// Load components from the file system
  static Future<void> _loadComponentsFromFileSystem(
    Map<String, bool> registeredComponents,
  ) async {
    debugPrint('Loading components from file system...');

    final componentsDir = Directory('lib/components');
    if (!componentsDir.existsSync()) {
      debugPrint('Components directory not found');
      return;
    }

    // Get all subdirectories in the components directory
    final categoryDirs =
        componentsDir.listSync().whereType<Directory>().toList();

    // Process each category directory
    for (final categoryDir in categoryDirs) {
      final categoryName = path.basename(categoryDir.path);
      final category = _getCategoryFromName(categoryName);

      // Skip the definitions directory as it contains component definitions, not actual components
      if (categoryName == 'definitions') {
        continue;
      }

      // Get all Dart files in the category directory and its subdirectories
      final componentFiles = _findDartFiles(categoryDir);

      // Process each component file
      for (final componentFile in componentFiles) {
        final fileName = path.basename(componentFile.path);

        // Skip files that are not components
        if (_shouldSkipFile(fileName)) {
          continue;
        }

        // Generate the component ID
        final normalizedPath = componentFile.path.replaceAll('\\', '/');
        final pathParts =
            normalizedPath.contains('lib/components/')
                ? normalizedPath.split('lib/components/')
                : normalizedPath.split('lib\\components\\');

        if (pathParts.length < 2) {
          continue;
        }

        final relativePath = pathParts[1];
        final id = _generateComponentId(relativePath);

        // Skip if this component has already been registered
        if (registeredComponents.containsKey(id)) {
          debugPrint('Skipping $id as it has already been registered');
          continue;
        }

        // Create a component model for the file
        final component = await _createComponentModelFromFile(
          componentFile.path,
          category,
        );

        if (component != null) {
          ComponentRegistry.register(component);
          registeredComponents[id] = true;
        }
      }
    }

    debugPrint(
      'Loaded ${ComponentRegistry.getAllComponents().length} components from file system',
    );
  }

  /// Find all Dart files in a directory and its subdirectories
  static List<File> _findDartFiles(Directory directory) {
    final List<File> dartFiles = [];

    try {
      final entities = directory.listSync(recursive: true);

      for (final entity in entities) {
        if (entity is File && entity.path.endsWith('.dart')) {
          dartFiles.add(entity);
        }
      }
    } catch (e) {
      debugPrint('Error finding Dart files: $e');
    }

    return dartFiles;
  }

  /// Check if a file should be skipped
  static bool _shouldSkipFile(String fileName) {
    // Skip files that are not components
    final skipPatterns = [
      '_test.dart',
      'provider.dart',
      'model.dart',
      'util.dart',
      'helper.dart',
      'extension.dart',
      'mixin.dart',
    ];

    for (final pattern in skipPatterns) {
      if (fileName.contains(pattern)) {
        return true;
      }
    }

    return false;
  }

  /// Get the category from the directory name
  static FlutterCategory _getCategoryFromName(String name) {
    switch (name) {
      case 'buttons':
        return FlutterCategory.button;
      case 'textfields':
        return FlutterCategory.textField;
      case 'images':
        return FlutterCategory.image;
      case 'appbar':
        return FlutterCategory.appBar;
      case 'list_tiles':
        return FlutterCategory.listTile;
      case 'texts':
        return FlutterCategory.text;
      case 'chips':
        return FlutterCategory.chip;
      case 'custom_shapes':
        return FlutterCategory.customShape;
      case 'icons':
        return FlutterCategory.icon;
      case 'views':
        return FlutterCategory.view;
      case 'layouts':
        return FlutterCategory.layout;
      case 'shimmers':
        return FlutterCategory.shimmer;
      case 'otp_input':
        return FlutterCategory.textField;
      case 'image_text':
        return FlutterCategory.image;
      case 'carousels':
        return FlutterCategory.carousel;
      default:
        return FlutterCategory.other;
    }
  }

  /// Create a component model from a file
  static Future<ComponentModel?> _createComponentModelFromFile(
    String filePath,
    FlutterCategory category,
  ) async {
    try {
      final fileName = path.basename(filePath);
      final componentName = fileName.replaceAll('.dart', '');

      // Extract the relative path from lib/components
      final normalizedPath = filePath.replaceAll('\\', '/');

      // Handle both Windows and Unix-style paths
      final pathParts =
          normalizedPath.contains('lib/components/')
              ? normalizedPath.split('lib/components/')
              : normalizedPath.split('lib\\components\\');

      if (pathParts.length < 2) {
        debugPrint('Could not extract relative path from: $normalizedPath');
        return null;
      }

      final relativePath = pathParts[1];
      final sourceCodePath = relativePath.replaceAll('.dart', '.txt');

      // Format the component name for display
      final formattedName = _formatComponentName(componentName);

      // Generate a unique ID
      final id = _generateComponentId(relativePath);

      // Create the component model
      return ComponentModel(
        id: id,
        name: formattedName,
        description: 'A $formattedName component',
        category: category,
        widgetBuilder: (customization) {
          // Use a placeholder widget for components without a specific builder
          return PlaceholderWidget.create(
            id,
            message:
                'This component uses the default placeholder. Add a component definition for a custom preview.',
          );
        },
        codeFilePath: sourceCodePath,
        defaultCustomization: CommonCustomizationModel(),
      );
    } catch (e) {
      debugPrint('Error creating component model for file $filePath: $e');
      return null;
    }
  }

  /// Format a component name for display
  static String _formatComponentName(String name) {
    // Remove common prefixes
    if (name.startsWith('t_')) {
      name = name.substring(2);
    } else if (name.startsWith('t')) {
      name = name.substring(1);
    }

    // Split by underscores and camel case
    final words = name
        .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'),
          (match) => '${match.group(1)} ${match.group(2)}',
        )
        .split('_');

    // Capitalize each word
    final formattedWords =
        words.map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1);
        }).toList();

    return formattedWords.join(' ');
  }

  /// Generate a unique ID for a component
  static String _generateComponentId(String relativePath) {
    // First, remove the file extension
    final pathWithoutExtension = relativePath.replaceAll('.dart', '');

    // Replace slashes with underscores
    final id = pathWithoutExtension.replaceAll('/', '_');

    debugPrint('Generated component ID: $id from path: $relativePath');
    return id;
  }
}
