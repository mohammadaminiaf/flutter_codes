import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/flutter_category.dart';
import '../providers/component_riverpod_provider.dart';
import '../screens/screen_desktop_layout.dart';

class CategoryNavigationSidebar extends ConsumerWidget {
  const CategoryNavigationSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Categories',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // All components option
                _buildCategoryItem(
                  context, 
                  ref,
                  null, 
                  'All Components', 
                  selectedCategory == null,
                  Icons.widgets,
                ),
                
                // Divider between All and specific categories
                const Divider(),
                
                // List all categories
                ...categories.map((category) => _buildCategoryItem(
                  context,
                  ref,
                  category,
                  category.name,
                  selectedCategory == category,
                  _getCategoryIcon(category),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryItem(
    BuildContext context,
    WidgetRef ref,
    FlutterCategory? category,
    String name,
    bool isSelected,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected 
            ? Theme.of(context).colorScheme.primary 
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected 
              ? Theme.of(context).colorScheme.primary 
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
      onTap: () {
        // Update the selected category
        ref.read(selectedCategoryProvider.notifier).state = category;
        // Clear the selected component when changing categories
        ref.read(selectedComponentIdProvider.notifier).state = null;
      },
    );
  }
  
  IconData _getCategoryIcon(FlutterCategory category) {
    switch (category) {
      case FlutterCategory.button:
        return Icons.smart_button;
      case FlutterCategory.textField:
        return Icons.text_fields;
      case FlutterCategory.dialog:
        return Icons.chat_bubble_outline;
      case FlutterCategory.appBar:
        return Icons.web;
      case FlutterCategory.drawer:
        return Icons.menu;
      case FlutterCategory.snackbar:
        return Icons.notifications;
      case FlutterCategory.bottomNavigationBar:
        return Icons.dock;
      case FlutterCategory.loadingIndicator:
        return Icons.refresh;
      case FlutterCategory.image:
        return Icons.image;
      case FlutterCategory.listTile:
        return Icons.list;
      case FlutterCategory.text:
        return Icons.text_format;
      case FlutterCategory.chip:
        return Icons.label;
      case FlutterCategory.customShape:
        return Icons.shape_line;
      case FlutterCategory.icon:
        return Icons.emoji_objects;
      case FlutterCategory.view:
        return Icons.view_agenda;
      case FlutterCategory.layout:
        return Icons.grid_view;
      case FlutterCategory.shimmer:
        return Icons.blur_on;
      default:
        return Icons.category;
    }
  }
}
