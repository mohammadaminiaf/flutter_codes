import 'package:flutter/material.dart';
import '../models/component_model.dart';
import '../screens/screen_component_details_lazy.dart';

/// A grid item for displaying a component with lazy loading
class ComponentGridItemLazy extends StatelessWidget {
  final ComponentModel component;

  const ComponentGridItemLazy({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      ScreenComponentDetailsLazy(componentId: component.id),
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
                color: Theme.of(context).primaryColor.withAlpha(204),
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
              // Tags
              if (component.tags.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 4.0,
                    runSpacing: 4.0,
                    children:
                        component.tags.map((tag) {
                          return Chip(
                            label: Text(
                              tag,
                              style: const TextStyle(fontSize: 10.0),
                            ),
                            padding: EdgeInsets.zero,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            labelPadding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                          );
                        }).toList(),
                  ),
                ),
              const Spacer(),
              // Category
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                color: Colors.grey.shade200,
                child: Text(
                  component.category.name,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
