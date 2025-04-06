part of 'customization_provider.dart';

/// State class to hold all component customizations
class CustomizationState {
  final Map<String, CustomizationModel?> customizations;

  CustomizationState({required this.customizations});

  /// Create an empty state
  CustomizationState.empty() : customizations = {};

  /// Create a copy of the state with updated customization for a specific component
  CustomizationState copyWith({
    String? componentId,
    CustomizationModel? customization,
  }) {
    if (componentId == null) {
      return this;
    }

    final newCustomizations = Map<String, CustomizationModel?>.from(customizations);
    newCustomizations[componentId] = customization;
    
    return CustomizationState(customizations: newCustomizations);
  }

  /// Reset a specific component's customization
  CustomizationState resetComponent(String componentId, CustomizationModel? defaultCustomization) {
    final newCustomizations = Map<String, CustomizationModel?>.from(customizations);
    newCustomizations[componentId] = defaultCustomization;
    
    return CustomizationState(customizations: newCustomizations);
  }
}