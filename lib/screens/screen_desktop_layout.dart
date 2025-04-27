import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/flutter_category.dart';
import '../providers/component_riverpod_provider.dart';
import '../widgets/category_navigation_sidebar.dart';
import '../widgets/widget_list_view.dart';
import 'screen_widget_detail_split.dart';

// Provider for the currently selected category
final selectedCategoryProvider = StateProvider<FlutterCategory?>((ref) => null);

// Provider for the currently selected component ID
final selectedComponentIdProvider = StateProvider<String?>((ref) => null);

class ScreenDesktopLayout extends ConsumerWidget {
  const ScreenDesktopLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final selectedComponentId = ref.watch(selectedComponentIdProvider);
    final categories = ref.watch(categoriesProvider);
    
    // If no category is selected, select the first one
    if (selectedCategory == null && categories.isNotEmpty) {
      Future.microtask(() => 
        ref.read(selectedCategoryProvider.notifier).state = categories.first
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI Components'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Left sidebar for category navigation
          const SizedBox(
            width: 250,
            child: CategoryNavigationSidebar(),
          ),
          
          // Vertical divider
          const VerticalDivider(width: 1),
          
          // Main content area
          Expanded(
            child: selectedComponentId != null
                ? ScreenWidgetDetailSplit(componentId: selectedComponentId)
                : const WidgetListView(),
          ),
        ],
      ),
    );
  }
}
