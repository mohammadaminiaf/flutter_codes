import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/component_riverpod_provider.dart';

/// A search widget for finding components
class ComponentSearch extends ConsumerStatefulWidget {
  const ComponentSearch({super.key});

  @override
  ConsumerState<ComponentSearch> createState() => _ComponentSearchState();
}

class _ComponentSearchState extends ConsumerState<ComponentSearch> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search components...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        Expanded(
          child: _searchQuery.isEmpty
              ? const Center(
                  child: Text('Search for components by name or description'),
                )
              : Consumer(
                  builder: (context, ref, child) {
                    final searchResults = ref.watch(searchComponentsProvider(_searchQuery));
                    
                    if (searchResults.isEmpty) {
                      return const Center(
                        child: Text('No components found'),
                      );
                    }
                    
                    return ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final component = searchResults[index];
                        return ListTile(
                          title: Text(component.name),
                          subtitle: Text(component.description),
                          trailing: Text(component.category.name),
                          onTap: () {
                            // Navigate to component details
                          },
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
