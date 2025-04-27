import 'package:flutter/material.dart';
import '../models/component_model.dart';
import 'widget_example_base.dart';

/// Example implementation for carousel components
class CarouselExample extends WidgetExampleBase {
  const CarouselExample({super.key, required super.component});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          height: 200,
          child: component.createWidget(),
        ),
      ),
    );
  }
}
