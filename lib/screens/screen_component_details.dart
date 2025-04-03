import 'package:flutter/material.dart';

import '/models/component_model.dart';
import '/widgets/component_preview.dart';
import '/widgets/source_code_viewer.dart';

class ScreenComponentDetails extends StatelessWidget {
  final ComponentModel component;

  const ScreenComponentDetails({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(component.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Component description
            Text(
              component.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),

            // Component preview
            Text('Preview:', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Center(child: ComponentPreview(component: component)),
            ),
            const SizedBox(height: 24),

            // Source code with syntax highlighting
            Text('Source Code:', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            // View Source Code Widget
            SourceCodeViewer(path: component.codeFilePath),
          ],
        ),
      ),
    );
  }
}

