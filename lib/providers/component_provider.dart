import 'package:flutter/material.dart';

import '/models/component_model.dart';
import '/models/flutter_category.dart';
import '../models/customization_models/customization_model.dart';

class ComponentProvider with ChangeNotifier {
  // Getter for all components
  List<ComponentModel> get _components => components;

  // Get component by ID
  ComponentModel getComponentById(String id) {
    return _components.firstWhere(
      (component) => component.id == id,
      orElse: () => throw Exception('Component not found'),
    );
  }

  // Get components by category
  List<ComponentModel> getComponentsByCategory(FlutterCategory category) {
    return _components
        .where((component) => component.category == category)
        .toList();
  }

  // Get all unique categories
  List<FlutterCategory> get categories {
    return _components.map((component) => component.category).toSet().toList();
  }
  
  // Update component customization
  void updateComponentCustomization(String componentId, CustomizationModel customization) {
    final component = getComponentById(componentId);
    component.currentCustomization = customization;
    notifyListeners();
  }
  
  // Reset component customization to default
  void resetComponentCustomization(String componentId) {
    final component = getComponentById(componentId);
    component.currentCustomization = component.defaultCustomization;
    notifyListeners();
  }
  
  // Get current customization for a component
  CustomizationModel? getComponentCustomization(String componentId) {
    final component = getComponentById(componentId);
    return component.currentCustomization ?? component.defaultCustomization;
  }
}
