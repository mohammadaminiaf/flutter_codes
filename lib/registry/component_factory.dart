import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../models/component_model.dart';
import '../models/flutter_category.dart';
import '../models/customization_models/common_customization_model.dart';
import '../registry/component_registry.dart';
import '../services/dynamic_component_factory.dart';

/// A factory class for creating and registering components.
/// This class provides methods to create components from the file system and register them.
class ComponentFactory {
  ComponentFactory._(); // Private constructor to prevent instantiation

  /// Discover and register all components in the components directory
  static void discoverAndRegisterComponents() {
    final componentsDir = Directory('lib/components');
    debugPrint('Looking for components in: ${componentsDir.absolute.path}');

    if (!componentsDir.existsSync()) {
      debugPrint('Components directory not found');
      return;
    }

    // Get all subdirectories in the components directory
    final categoryDirs =
        componentsDir.listSync().whereType<Directory>().toList();
    debugPrint('Found ${categoryDirs.length} category directories');

    // Process each category directory
    for (final categoryDir in categoryDirs) {
      final categoryName = path.basename(categoryDir.path);
      final category = _getCategoryFromName(categoryName);
      debugPrint('Processing category: $categoryName');

      // Get all Dart files in the category directory and its subdirectories
      final componentFiles = _findDartFiles(categoryDir);
      debugPrint('Found ${componentFiles.length} Dart files in $categoryName');

      // Process each component file
      for (final componentFile in componentFiles) {
        final fileName = path.basename(componentFile.path);
        final componentName = fileName.replaceAll('.dart', '');
        debugPrint('Processing file: $fileName');

        // Skip files that are not components
        if (_shouldSkipFile(fileName)) {
          debugPrint('Skipping file: $fileName');
          continue;
        }

        // Create a component model for the file
        final component = _createComponentModel(
          componentFile.path,
          componentName,
          category,
        );

        if (component != null) {
          debugPrint('Registering component: ${component.name}');
          ComponentRegistry.register(component);
        } else {
          debugPrint('Failed to create component for: $fileName');
        }
      }
    }

    // Print the total number of registered components
    debugPrint(
      'Total registered components: ${ComponentRegistry.getAllComponents().length}',
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
      default:
        return FlutterCategory.other;
    }
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

  /// Create a component model from a file
  static ComponentModel? _createComponentModel(
    String filePath,
    String componentName,
    FlutterCategory category,
  ) {
    try {
      // Extract the relative path from lib/components
      final normalizedPath = filePath.replaceAll('\\', '/');
      final relativePath = normalizedPath.split('lib/components/')[1];
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
          try {
            // Try to create the widget using DynamicComponentFactory
            // This is a fallback mechanism for components that don't have a builder
            return DynamicComponentFactory.createWidget(id);
          } catch (e) {
            // If that fails, show a placeholder
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Component preview not available'),
                  const SizedBox(height: 8),
                  Text(
                    'Error: $e',
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ],
              ),
            );
          }
        },
        codeFilePath: sourceCodePath,
        defaultCustomization: CommonCustomizationModel(),
      );
    } catch (e) {
      debugPrint('Error creating component model for $componentName: $e');
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
