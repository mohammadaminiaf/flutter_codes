import 'package:flutter/material.dart';
import '../models/component_model.dart';

class ComponentPreview extends StatelessWidget {
  final ComponentModel component;

  const ComponentPreview({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    // Based on the component ID, return the appropriate widget
    return component.widget;
  }
}