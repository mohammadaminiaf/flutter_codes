import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/component_riverpod_provider.dart';
import '../widgets/component_grid_paginated.dart';
import '../widgets/component_search.dart';

class ScreenHomeNew extends ConsumerStatefulWidget {
  const ScreenHomeNew({super.key});

  @override
  ConsumerState<ScreenHomeNew> createState() => _ScreenHomeNewState();
}

class _ScreenHomeNewState extends ConsumerState<ScreenHomeNew>
    with TickerProviderStateMixin {
  TabController? _tabController;
  bool _isSearchMode = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the categories and update the tab controller
    final categories = ref.read(categoriesProvider);

    // Dispose the old controller if it exists
    _tabController?.dispose();

    // Create a new controller with the correct length
    _tabController = TabController(
      length: categories.length + 1, // Add 1 for the "All" tab
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI Components'),
        actions: [
          IconButton(
            icon: Icon(_isSearchMode ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearchMode = !_isSearchMode;
              });
            },
          ),
        ],
      ),
      body:
          _isSearchMode
              ? const ComponentSearch()
              : Column(
                children: [
                  if (_tabController != null)
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      tabs: [
                        const Tab(text: 'All'),
                        ...categories.map(
                          (category) => Tab(text: category.name),
                        ),
                      ],
                    ),
                  Expanded(
                    child:
                        _tabController == null
                            ? const Center(child: CircularProgressIndicator())
                            : TabBarView(
                              controller: _tabController,
                              children: [
                                // All components tab
                                const ComponentGridPaginated(),
                                // Category-specific tabs
                                ...categories.map((category) {
                                  return ComponentGridPaginated(
                                    category: category,
                                  );
                                }),
                              ],
                            ),
                  ),
                ],
              ),
    );
  }
}
