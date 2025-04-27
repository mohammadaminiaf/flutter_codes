import 'package:flutter/material.dart';
import '../models/component_model.dart';
import 'widget_example_base.dart';

/// Example implementation for Text widgets
class TextExample extends WidgetExampleBase {
  const TextExample({super.key, required super.component});

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
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.article, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Blog Post',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Published on May 15, 2023',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'Flutter UI Design Principles',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Author
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/32.jpg',
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'By John Doe',
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Content with our component
          _wrapWithBuilder(component.createWidget()),

          const SizedBox(height: 16),

          // Continue reading
          const Text(
            "Flutter's design is based on Material Design principles, which emphasize clean, minimalist interfaces with subtle animations and transitions that provide visual feedback to users.",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.thumb_up_outlined),
                    onPressed: () {},
                  ),
                  const Text('124'),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.comment_outlined),
                    onPressed: () {},
                  ),
                  const Text('32'),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _wrapWithBuilder(Widget text) {
    // If the text widget doesn't have proper styling, replace it with a more visible example
    if (text is! Text) {
      return const Text(
        "Flutter's design system is built around three core principles: Material Design, responsive layouts, and platform adaptivity. These principles guide developers in creating applications that are visually appealing, functionally efficient, and consistent across different devices and platforms.",
        style: TextStyle(fontSize: 16, height: 1.5),
      );
    }

    return text;
  }
}
