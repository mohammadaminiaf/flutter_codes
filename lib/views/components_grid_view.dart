import 'package:flutter/material.dart';

import '/models/component_model.dart';
import '/widgets/component_grid_item.dart';

class ComponentsGridView extends StatelessWidget {
  final List<ComponentModel> components;

  const ComponentsGridView({super.key, required this.components});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        mainAxisExtent: 300 ,
        childAspectRatio: 1/ 1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: components.length,
      itemBuilder: (ctx, index) {
        final component = components[index];
        return ComponentGridItem(component: component);
      },
    );
  }
}

