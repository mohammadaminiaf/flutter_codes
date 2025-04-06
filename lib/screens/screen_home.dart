import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/flutter_category.dart';
import '/providers/component_riverpod_provider.dart';
import '../views/components_grid_view.dart';

class ScreenHome extends ConsumerStatefulWidget {
  const ScreenHome({super.key});

  @override
  ConsumerState<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends ConsumerState<ScreenHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: FlutterCategory.values.length, vsync: this);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    // If categoriesProvider doesn't return FlutterCategory.values directly, use this instead
    // final categories = FlutterCategory.values;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI Components'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: categories.map((category) => Tab(text: category.name)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: categories.map((category) {
          // Use Riverpod provider to get components by category
          final categoryComponents = ref.watch(componentsByCategoryProvider(category));
          return ComponentsGridView(components: categoryComponents);
        }).toList(),
      ),
    );
  }
}