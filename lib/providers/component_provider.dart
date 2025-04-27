import 'package:flutter/material.dart';

import '../models/component_model.dart';
import '../models/flutter_category.dart';
import '../registry/component_registry.dart';

class ComponentProvider with ChangeNotifier {
  // Get component by ID
  ComponentModel? getComponentById(String id) {
    return ComponentRegistry.getComponentById(id);
  }

  // Get components by category
  List<ComponentModel> getComponentsByCategory(FlutterCategory category) {
    return ComponentRegistry.getComponentsByCategory(category);
  }

  // Get all components
  List<ComponentModel> get allComponents {
    return ComponentRegistry.getAllComponents();
  }

  // Get all unique categories
  List<FlutterCategory> get categories {
    return ComponentRegistry.getAllComponents()
        .map((component) => component.category)
        .toSet()
        .toList();
  }

  // Search components
  List<ComponentModel> searchComponents(String query) {
    if (query.isEmpty) {
      return allComponents;
    }

    final lowercaseQuery = query.toLowerCase();
    return allComponents.where((component) {
      return component.name.toLowerCase().contains(lowercaseQuery) ||
          component.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}
