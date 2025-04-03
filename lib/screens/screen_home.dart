import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/flutter_category.dart';
import '/providers/component_provider.dart';
import '../views/components_grid_view.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> with SingleTickerProviderStateMixin {
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
    final componentProvider = Provider.of<ComponentProvider>(context);
    final categories = FlutterCategory.values;

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
          final categoryComponents = componentProvider.getComponentsByCategory(category);
          return ComponentsGridView(components: categoryComponents);
        }).toList(),
      ),
    );
  }
}