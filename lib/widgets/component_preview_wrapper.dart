import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_model.dart';
import '../widget_examples/widget_example_factory.dart';

/// A wrapper widget that provides proper constraints for component previews
class ComponentPreviewWrapper extends ConsumerWidget {
  final ComponentModel component;

  const ComponentPreviewWrapper({super.key, required this.component});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create a widget with appropriate constraints
    return SizedBox(
      width: 400,
      height: 400,
      child: WidgetExampleFactory.createExample(component),
    );
  }
}
