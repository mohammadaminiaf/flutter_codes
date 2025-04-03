import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/component_provider.dart';

/// A reusable reset button widget for customization panels
class ResetButton extends StatelessWidget {
  final String componentId;

  const ResetButton({
    super.key,
    required this.componentId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ComponentProvider>(context, listen: false);
    
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          provider.resetComponentCustomization(componentId);
        },
        icon: const Icon(Icons.refresh),
        label: const Text('Reset to Default'),
      ),
    );
  }
}