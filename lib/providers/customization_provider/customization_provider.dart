import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/component_model.dart';
import '/models/customization_models/customization_model.dart';

part 'customization_state.dart';

/// Notifier class to manage customization state
class CustomizationNotifier extends StateNotifier<CustomizationState> {
  CustomizationNotifier() : super(CustomizationState.empty()) {
    _initializeCustomizations();
  }

  /// Initialize customizations with default values from components list
  void _initializeCustomizations() {
    final initialCustomizations = <String, CustomizationModel?>{};

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
    final component = components.firstWhere(
      (component) => component.id == componentId,
      orElse: () => throw Exception('Component not found'),
    );

    state = state.resetComponent(componentId, component.defaultCustomization);
  }

  /// Get current customization for a component
  CustomizationModel? getComponentCustomization(String componentId) {
    return state.customizations[componentId] ??
        components
            .firstWhere(
              (component) => component.id == componentId,
              orElse: () => throw Exception('Component not found'),
            )
            .defaultCustomization;
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
      return customizationState.customizations[componentId] ??
          components
              .firstWhere(
                (component) => component.id == componentId,
                orElse: () => throw Exception('Component not found'),
              )
              .defaultCustomization;
    });
