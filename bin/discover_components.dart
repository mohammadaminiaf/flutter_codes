import 'dart:io';
import 'package:path/path.dart' as path;

void main() {
  discoverComponents();
}

void discoverComponents() {
  final componentsDir = Directory('lib/components');
  print('Looking for components in: ${componentsDir.absolute.path}');
  
  if (!componentsDir.existsSync()) {
    print('Components directory not found');
    return;
  }
  
  // Get all subdirectories in the components directory
  final categoryDirs = componentsDir.listSync().whereType<Directory>().toList();
  print('Found ${categoryDirs.length} category directories:');
  for (final dir in categoryDirs) {
    print('  - ${path.basename(dir.path)}');
  }
  
  // Process each category directory
  for (final categoryDir in categoryDirs) {
    final categoryName = path.basename(categoryDir.path);
    print('\nProcessing category: $categoryName');
    
    // Get all Dart files in the category directory and its subdirectories
    final componentFiles = _findDartFiles(categoryDir);
    print('Found ${componentFiles.length} Dart files in $categoryName:');
    
    // Process each component file
    for (final componentFile in componentFiles) {
      final fileName = path.basename(componentFile.path);
      print('  - $fileName');
    }
  }
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
