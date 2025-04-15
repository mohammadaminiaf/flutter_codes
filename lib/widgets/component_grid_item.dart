import 'package:flutter/material.dart';

import '/models/component_model.dart';
import '/screens/screen_component_details.dart';

class ComponentGridItem extends StatelessWidget {
  final ComponentModel component;

  const ComponentGridItem({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScreenComponentDetails(component: component),
          ),
        );
      },
      child: SizedBox(
        height: 300,
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              child: Text(
                component.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Description
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                component.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            // Component preview with proper constraints
            // Wrap in Expanded and ConstrainedBox to prevent infinite size issues
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 50,
                        maxWidth: constraints.maxWidth,
                        minHeight: 50,
                        maxHeight: constraints.maxHeight,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        alignment: Alignment.center,
                        child: component.widgetBuilder(component.currentCustomization),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
