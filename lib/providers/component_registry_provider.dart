import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_model.dart';
import '../models/flutter_category.dart';
import '../services/component_discovery_service.dart';

/// Provider for all components
final allComponentsProvider = Provider<List<ComponentModel>>((ref) {
  return ComponentDiscoveryService.discoverComponents();
});

/// Provider for getting a component by ID
final componentByIdProvider = Provider.family<ComponentModel?, String>((
  ref,
  id,
) {
  final components = ref.watch(allComponentsProvider);
  return components.firstWhere((component) => component.id == id);
});

/// Provider for getting components by category
final componentsByCategoryProvider =
    Provider.family<List<ComponentModel>, FlutterCategory>((ref, category) {
      final components = ref.watch(allComponentsProvider);
      return components
          .where((component) => component.category == category)
          .toList();
    });

/// Provider for getting all unique categories
final categoriesProvider = Provider<List<FlutterCategory>>((ref) {
  final components = ref.watch(allComponentsProvider);
  return components.map((component) => component.category).toSet().toList();
});

/// Provider for searching components
final searchComponentsProvider = Provider.family<List<ComponentModel>, String>((
  ref,
  query,
) {
  final components = ref.watch(allComponentsProvider);
  if (query.isEmpty) {
    return components;
  }

  final lowercaseQuery = query.toLowerCase();
  return components.where((component) {
    return component.name.toLowerCase().contains(lowercaseQuery) ||
        component.description.toLowerCase().contains(lowercaseQuery);
  }).toList();
});
