import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/customization_provider/customization_provider.dart';

/// A reusable reset button widget for customization panels
class ResetButton extends ConsumerWidget {
  final String componentId;
  final VoidCallback? onPressed;

  const ResetButton({
    super.key,
    required this.componentId,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If onPressed is provided, use it (for custom implementation)
    // Otherwise, use Riverpod implementation
    final callback = onPressed ?? () {
      // Use Riverpod's CustomizationNotifier to reset the component
      ref.read(customizationProvider.notifier).resetComponentCustomization(componentId);
    };
    
    return Center(
      child: ElevatedButton.icon(
        onPressed: callback,
        icon: const Icon(Icons.refresh),
        label: const Text('Reset to Default'),
      ),
    );
  }
}