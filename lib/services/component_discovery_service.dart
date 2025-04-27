import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../models/component_model.dart';
import '../models/flutter_category.dart';
import '../models/customization_models/common_customization_model.dart';

/// A service for discovering components in the codebase
class ComponentDiscoveryService {
  ComponentDiscoveryService._(); // Private constructor to prevent instantiation
  
  /// Discover all components in the components directory
  static List<ComponentModel> discoverComponents() {
    final List<ComponentModel> components = [];
    final componentsDir = Directory('lib/components');
    
    if (!componentsDir.existsSync()) {
      print('Components directory not found');
      return components;
    }
    
    // Get all subdirectories in the components directory
    final categoryDirs = componentsDir.listSync()
        .whereType<Directory>()
        .toList();
    
    // Process each category directory
    for (final categoryDir in categoryDirs) {
      final categoryName = path.basename(categoryDir.path);
      final category = _getCategoryFromName(categoryName);
      
      // Get all Dart files in the category directory and its subdirectories
      final componentFiles = _findDartFiles(categoryDir);
      
      // Process each component file
      for (final componentFile in componentFiles) {
        final fileName = path.basename(componentFile.path);
        final componentName = fileName.replaceAll('.dart', '');
        
        // Skip files that are not components
        if (_shouldSkipFile(fileName)) {
          continue;
        }
        
        // Create a component model for the file
        final component = _createComponentModel(
          componentFile.path,
          componentName,
          category,
        );
        
        if (component != null) {
          components.add(component);
        }
      }
    }
    
    return components;
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
      print('Error finding Dart files: $e');
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
      final relativePath = filePath.split('lib/components/')[1];
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
          // This is a placeholder. The actual widget will be created dynamically
          // when the component is selected for preview
          return const Center(
            child: Text('Component preview will be shown here'),
          );
        },
        codeFilePath: sourceCodePath,
        defaultCustomization: CommonCustomizationModel(),
      );
    } catch (e) {
      print('Error creating component model for $componentName: $e');
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
    final words = name.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)} ${match.group(2)}',
    ).split('_');
    
    // Capitalize each word
    final formattedWords = words.map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1);
    }).toList();
    
    return formattedWords.join(' ');
  }
  
  /// Generate a unique ID for a component
  static String _generateComponentId(String relativePath) {
    // Replace slashes and dots with underscores
    return relativePath.replaceAll('/', '_').replaceAll('.', '_');
  }
}
