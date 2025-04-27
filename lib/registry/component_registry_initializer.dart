import 'package:flutter/foundation.dart';
import '../services/component_loader_service.dart';
import '../services/source_code_generation_service.dart';

/// Initializes the component registry with all available components.
class ComponentRegistryInitializer {
  ComponentRegistryInitializer._(); // Private constructor to prevent instantiation

  /// Initialize the component registry with all components
  static Future<void> initialize() async {
    debugPrint('Initializing component registry...');

    try {
      // Generate source code files for all components
      debugPrint('Generating source code files...');
      await SourceCodeGenerationService.generateSourceCodeFiles();
      debugPrint('Source code files generated');

      // Load all components using the component loader service
      // This service handles loading components from all sources
      await ComponentLoaderService.loadAllComponents();
    } catch (e) {
      debugPrint('Error initializing component registry: $e');
    }
  }
}
