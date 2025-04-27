import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/flutter_category.dart';
import '../providers/component_riverpod_provider.dart';
import 'component_grid_item_lazy.dart';

/// A paginated grid for displaying components
class ComponentGridPaginated extends ConsumerStatefulWidget {
  final FlutterCategory? category;
  final int itemsPerPage;

  const ComponentGridPaginated({
    super.key,
    this.category,
    this.itemsPerPage = 12,
  });

  @override
  ConsumerState<ComponentGridPaginated> createState() =>
      _ComponentGridPaginatedState();
}

class _ComponentGridPaginatedState
    extends ConsumerState<ComponentGridPaginated> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final components =
        widget.category != null
            ? ref.watch(componentsByCategoryProvider(widget.category!))
            : ref.watch(allComponentsProvider);

    if (components.isEmpty) {
      return const Center(child: Text('No components found'));
    }

    final totalPages = (components.length / widget.itemsPerPage).ceil();
    final startIndex = _currentPage * widget.itemsPerPage;
    final endIndex =
        (startIndex + widget.itemsPerPage) > components.length
            ? components.length
            : startIndex + widget.itemsPerPage;

    final displayedComponents = components.sublist(startIndex, endIndex);

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 1.0,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: displayedComponents.length,
            itemBuilder: (context, index) {
              final component = displayedComponents[index];
              return ComponentGridItemLazy(component: component);
            },
          ),
        ),
        if (totalPages > 1)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed:
                      _currentPage > 0
                          ? () {
                            setState(() {
                              _currentPage--;
                            });
                          }
                          : null,
                ),
                Text(
                  'Page ${_currentPage + 1} of $totalPages',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed:
                      _currentPage < totalPages - 1
                          ? () {
                            setState(() {
                              _currentPage++;
                            });
                          }
                          : null,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
