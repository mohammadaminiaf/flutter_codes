import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/customization_models/customization_model.dart';
import '/registry/component_registry.dart';

part 'customization_state.dart';

/// Notifier class to manage customization state
class CustomizationNotifier extends StateNotifier<CustomizationState> {
  CustomizationNotifier() : super(CustomizationState.empty()) {
    _initializeCustomizations();
  }

  /// Initialize customizations with default values from component registry
  void _initializeCustomizations() {
    final initialCustomizations = <String, CustomizationModel?>{};
    final components = ComponentRegistry.getAllComponents();

    for (final component in components) {
      initialCustomizations[component.id] = component.defaultCustomization;
    }

    state = CustomizationState(customizations: initialCustomizations);
  }

  /// Update customization for a specific component
  void updateComponentCustomization(
    String componentId,
    CustomizationModel customization,
  ) {
    state = state.copyWith(
      componentId: componentId,
      customization: customization,
    );
  }

  /// Reset customization to default for a specific component
  void resetComponentCustomization(String componentId) {
    final component = ComponentRegistry.getComponent(componentId);
    if (component == null) {
      return;
    }

    state = state.resetComponent(componentId, component.defaultCustomization);
  }

  /// Get current customization for a component
  CustomizationModel? getComponentCustomization(String componentId) {
    final component = ComponentRegistry.getComponent(componentId);
    if (component == null) {
      return null;
    }

    return state.customizations[componentId] ?? component.defaultCustomization;
  }
}

/// Global provider for customization state
final customizationProvider =
    StateNotifierProvider<CustomizationNotifier, CustomizationState>(
      (ref) => CustomizationNotifier(),
    );

/// Provider to get a specific component's customization
final componentCustomizationProvider =
    Provider.family<CustomizationModel?, String>((ref, componentId) {
      final customizationState = ref.watch(customizationProvider);
      final component = ComponentRegistry.getComponent(componentId);

      if (component == null) {
        return null;
      }

      return customizationState.customizations[componentId] ??
          component.defaultCustomization;
    });
