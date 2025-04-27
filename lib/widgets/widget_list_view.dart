import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_model.dart';
import '../providers/component_riverpod_provider.dart';
import '../screens/screen_desktop_layout.dart';

class WidgetListView extends ConsumerWidget {
  const WidgetListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    // Get components based on selected category
    final components =
        selectedCategory == null
            ? ref.watch(allComponentsProvider)
            : ref.watch(componentsByCategoryProvider(selectedCategory));

    if (components.isEmpty) {
      return const Center(child: Text('No components found in this category'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with category name
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            selectedCategory == null ? 'All Components' : selectedCategory.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),

        // Component grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 1.0,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: components.length,
            itemBuilder: (context, index) {
              final component = components[index];
              return _buildComponentCard(context, ref, component);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildComponentCard(
    BuildContext context,
    WidgetRef ref,
    ComponentModel component,
  ) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: InkWell(
        onTap: () {
          // Set the selected component ID
          ref.read(selectedComponentIdProvider.notifier).state = component.id;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Component preview
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                color: Colors.grey.shade100,
                child: Center(
                  child: Text(
                    component.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),

            // Component name and description
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    component.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    component.description,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
