import 'package:flutter/material.dart';
import 'package:flutter_codes/models/component_model.dart';

class DefaultExample extends StatelessWidget {
  final ComponentModel component;

  const DefaultExample({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: component.createWidget());
  }
}
