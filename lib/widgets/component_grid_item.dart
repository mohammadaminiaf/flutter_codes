import 'package:flutter/material.dart';

import '/models/component_model.dart';
import '../screens/screen_component_details.dart';

class ComponentGridItem extends StatelessWidget {
  final ComponentModel component;

  const ComponentGridItem({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ScreenComponentDetails(component: component),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Component name as header
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
            // Component description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  component.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),

            // Component itself
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: component.widgetBuilder(component.currentCustomization), // Fixed by properly calling the widgetBuilder function with currentCustomization
              ),
            )
          ],
        ),
      ),
    );
  }
}