import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'models/component_model.dart';
import 'models/flutter_category.dart';
import 'registry/component_registry.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Component Discovery Test'),
        ),
        body: FutureBuilder<List<ComponentModel>>(
          future: discoverComponents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            
            final components = snapshot.data ?? [];
            
            if (components.isEmpty) {
              return const Center(child: Text('No components found'));
            }
            
            return ListView.builder(
              itemCount: components.length,
              itemBuilder: (context, index) {
                final component = components[index];
                return ListTile(
                  title: Text(component.name),
                  subtitle: Text(component.category.name),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

Future<List<ComponentModel>> discoverComponents() async {
  final componentsDir = Directory('lib/components');
  print('Looking for components in: ${componentsDir.absolute.path}');
  
  if (!componentsDir.existsSync()) {
    print('Components directory not found');
    return [];
  }
  
  final components = <ComponentModel>[];
  
  // Get all subdirectories in the components directory
  final categoryDirs = componentsDir.listSync().whereType<Directory>().toList();
  print('Found ${categoryDirs.length} category directories');
  
  // Process each category directory
  for (final categoryDir in categoryDirs) {
    final categoryName = path.basename(categoryDir.path);
    final category = _getCategoryFromName(categoryName);
    print('Processing category: $categoryName');
    
    // Get all Dart files in the category directory and its subdirectories
    final componentFiles = _findDartFiles(categoryDir);
    print('Found ${componentFiles.length} Dart files in $categoryName');
    
    // Process each component file
    for (final componentFile in componentFiles) {
      final fileName = path.basename(componentFile.path);
      final componentName = fileName.replaceAll('.dart', '');
      print('Processing file: $fileName');
      
      // Skip files that are not components
      if (_shouldSkipFile(fileName)) {
        print('Skipping file: $fileName');
        continue;
      }
      
      // Create a component model for the file
      final component = _createComponentModel(
        componentFile.path,
        componentName,
        category,
      );
      
      if (component != null) {
        print('Adding component: ${component.name}');
        components.add(component);
      } else {
        print('Failed to create component for: $fileName');
      }
    }
  }
  
  print('Total components found: ${components.length}');
  return components;
}

List<File> _findDartFiles(Directory directory) {
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

FlutterCategory _getCategoryFromName(String name) {
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

bool _shouldSkipFile(String fileName) {
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

ComponentModel? _createComponentModel(
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
        // This is a placeholder. The actual widget will be created dynamically
        // when the component is selected for preview
        return const Center(
          child: Text('Component preview will be shown here'),
        );
      },
      codeFilePath: sourceCodePath,
      defaultCustomization: null,
    );
  } catch (e) {
    print('Error creating component model for $componentName: $e');
    return null;
  }
}

String _formatComponentName(String name) {
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
  final formattedWords = words.map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1);
  }).toList();
  
  return formattedWords.join(' ');
}

String _generateComponentId(String relativePath) {
  // Replace slashes and dots with underscores
  return relativePath.replaceAll('/', '_').replaceAll('.', '_');
}
