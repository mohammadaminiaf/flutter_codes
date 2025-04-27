import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_model.dart';
import '../models/flutter_category.dart';
import '../registry/component_registry.dart';

/// Provider for getting a component by ID
final componentByIdProvider = Provider.family<ComponentModel?, String>((
  ref,
  id,
) {
  return ComponentRegistry.getComponent(id);
});

/// Provider for getting components by category
final componentsByCategoryProvider =
    Provider.family<List<ComponentModel>, FlutterCategory>((ref, category) {
      return ComponentRegistry.getComponentsByCategory(category);
    });

/// Provider for getting all unique categories
final categoriesProvider = Provider<List<FlutterCategory>>((ref) {
  return ComponentRegistry.getAllCategories();
});

/// Provider for searching components
final searchComponentsProvider = Provider.family<List<ComponentModel>, String>((
  ref,
  query,
) {
  if (query.isEmpty) {
    return ComponentRegistry.getAllComponents();
  }
  return ComponentRegistry.searchComponents(query);
});

/// Provider for getting all components
final allComponentsProvider = Provider<List<ComponentModel>>((ref) {
  return ComponentRegistry.getAllComponents();
});

/// Provider for getting the current customization for a component
final componentCustomizationProvider = Provider.family<dynamic, String>((
  ref,
  id,
) {
  // This is a placeholder. In a real app, this would return the current customization for the component.
  return null;
});
