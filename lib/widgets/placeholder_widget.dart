import 'package:flutter/material.dart';

/// Creates a placeholder widget for components that don't have a specific builder
class PlaceholderWidget {
  /// Create a placeholder widget with a message
  static Widget create(String componentId, {String? message}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.widgets_outlined, color: Colors.orange, size: 48),
          const SizedBox(height: 16),
          Text(
            message ?? 'Component preview not available',
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text('ID: $componentId', style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
