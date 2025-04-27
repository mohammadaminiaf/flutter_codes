import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

/// A service for generating source code files for components
class SourceCodeGenerationService {
  SourceCodeGenerationService._(); // Private constructor to prevent instantiation

  /// Generate source code files for all components
  static Future<void> generateSourceCodeFiles() async {
    final componentsDir = Directory('lib/components');

    if (!componentsDir.existsSync()) {
      debugPrint('Components directory not found');
      return;
    }

    // Create the assets/component_codes directory if it doesn't exist
    final sourceCodeDir = Directory('assets/component_codes');
    if (!sourceCodeDir.existsSync()) {
      sourceCodeDir.createSync(recursive: true);
    }

    // Get all Dart files in the components directory and its subdirectories
    final componentFiles = _findDartFiles(componentsDir);

    // Process each component file
    for (final componentFile in componentFiles) {
      // Skip files that are not components
      if (_shouldSkipFile(componentFile.path)) {
        continue;
      }

      // Extract the relative path from lib/components
      final normalizedPath = componentFile.path.replaceAll('\\', '/');

      // Handle both Windows and Unix-style paths
      final pathParts =
          normalizedPath.contains('lib/components/')
              ? normalizedPath.split('lib/components/')
              : normalizedPath.split('lib\\components\\');

      if (pathParts.length < 2) {
        debugPrint('Could not extract relative path from: $normalizedPath');
        continue;
      }

      final relativePath = pathParts[1];
      final sourceCodePath = relativePath.replaceAll('.dart', '.txt');

      // Create the directory structure if it doesn't exist
      final sourceCodeFilePath = path.join(sourceCodeDir.path, sourceCodePath);
      final sourceCodeFileDir = Directory(path.dirname(sourceCodeFilePath));
      if (!sourceCodeFileDir.existsSync()) {
        sourceCodeFileDir.createSync(recursive: true);
      }

      // Read the component file
      final sourceCode = await File(componentFile.path).readAsString();

      // Write the source code to the file
      await File(sourceCodeFilePath).writeAsString(sourceCode);

      debugPrint('Generated source code file: $sourceCodeFilePath');
    }
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
  static bool _shouldSkipFile(String filePath) {
    final fileName = path.basename(filePath);

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
}
