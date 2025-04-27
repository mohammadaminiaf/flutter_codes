import 'package:flutter/material.dart';
import '../models/component_model.dart';

/// Base class for widget examples
abstract class WidgetExampleBase extends StatelessWidget {
  final ComponentModel component;
  
  const WidgetExampleBase({super.key, required this.component});
  
  @override
  Widget build(BuildContext context);
}

/// Default example implementation that just shows the widget
class DefaultWidgetExample extends WidgetExampleBase {
  const DefaultWidgetExample({super.key, required super.component});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: component.createWidget(),
      ),
    );
  }
}
