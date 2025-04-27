import 'package:flutter/material.dart';
import 'widget_example_base.dart';

/// Example implementation for Button widgets
class ButtonExample extends WidgetExampleBase {
  const ButtonExample({super.key, required super.component});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          const Text(
            'User Registration',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // Form fields
          const TextField(
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),

          // Button section
          Row(
            children: [
              Expanded(child: _wrapWithBuilder(component.createWidget())),
            ],
          ),
        ],
      ),
    );
  }

  Widget _wrapWithBuilder(Widget button) {
    // If the button is too small or doesn't have text, replace it with a more visible example
    if (button is SizedBox && (button.width == null || button.width! < 100)) {
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text('Register Now'),
      );
    }

    return button;
  }
}
