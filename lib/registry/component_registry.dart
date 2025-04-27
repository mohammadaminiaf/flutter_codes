import '../models/component_model.dart';
import '../models/flutter_category.dart';

/// A registry for managing UI components in the application.
/// This class provides methods to register, retrieve, and filter components.
class ComponentRegistry {
  ComponentRegistry._(); // Private constructor to prevent instantiation

  /// Map of all registered components, keyed by their ID
  static final Map<String, ComponentModel> _components = {};

  /// Register a component in the registry
  static void register(ComponentModel component) {
    _components[component.id] = component;
  }

  /// Register multiple components at once
  static void registerAll(List<ComponentModel> components) {
    for (final component in components) {
      register(component);
    }
  }

  /// Get a component by its ID
  static ComponentModel? getComponent(String id) {
    return _components[id];
  }

  /// Get a component by its ID (alias for getComponent)
  static ComponentModel? getComponentById(String id) {
    return getComponent(id);
  }

  /// Get all registered components
  static List<ComponentModel> getAllComponents() {
    return _components.values.toList();
  }

  /// Get components by category
  static List<ComponentModel> getComponentsByCategory(
    FlutterCategory category,
  ) {
    return _components.values
        .where((component) => component.category == category)
        .toList();
  }

  /// Get all unique categories of registered components
  static List<FlutterCategory> getAllCategories() {
    return _components.values
        .map((component) => component.category)
        .toSet()
        .toList();
  }

  /// Search components by name or description
  static List<ComponentModel> searchComponents(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _components.values
        .where(
          (component) =>
              component.name.toLowerCase().contains(lowercaseQuery) ||
              component.description.toLowerCase().contains(lowercaseQuery),
        )
        .toList();
  }

  /// Clear all registered components
  static void clear() {
    _components.clear();
  }
}
