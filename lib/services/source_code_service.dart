import 'package:flutter/services.dart';

/// A service for loading and managing component source code.
class SourceCodeService {
  SourceCodeService._(); // Private constructor to prevent instantiation
  
  static const String _basePath = 'assets/component_codes/';
  
  /// Load source code for a component
  static Future<String> loadSourceCode(String path) async {
    try {
      return await rootBundle.loadString('$_basePath$path');
    } catch (e) {
      return 'Source code not available: $e';
    }
  }
  
  /// Get the path for a component's source code
  static String getSourceCodePath(String componentId, String category) {
    return '$category/$componentId.txt';
  }
}
