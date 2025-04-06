import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_model.dart';
import '../models/flutter_category.dart';

/// Provider for getting a component by ID
final componentByIdProvider = Provider.family<ComponentModel, String>(
  (ref, id) {
    return components.firstWhere(
      (component) => component.id == id,
      orElse: () => throw Exception('Component not found'),
    );
  },
);

/// Provider for getting components by category
final componentsByCategoryProvider = Provider.family<List<ComponentModel>, FlutterCategory>(
  (ref, category) {
    return components
        .where((component) => component.category == category)
        .toList();
  },
);

/// Provider for getting all unique categories
final categoriesProvider = Provider<List<FlutterCategory>>(
  (ref) {
    return FlutterCategory.values;
  },
);