import 'package:flutter/material.dart';

import '/models/component_model.dart';
import '../screens/screen_component_details_riverpod.dart';

class ComponentGridItem extends StatelessWidget {
  final ComponentModel component;

  const ComponentGridItem({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ScreenComponentDetailsRiverpod(
                component: component,
              ),
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
            // TextField with Flexible
            // Component preview with proper constraints
            SizedBox(
              height: 200,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: component.widgetBuilder(component.currentCustomization),
              ),
            ),
          ],
        ),
      ),
    );
  }
}