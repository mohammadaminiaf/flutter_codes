import 'package:flutter/material.dart';
import '../models/component_model.dart';
import '../models/flutter_category.dart';
import 'widget_example_base.dart';

/// Example implementation for AppBar widgets
class AppBarExample extends WidgetExampleBase {
  const AppBarExample({super.key, required super.component});

  @override
  Widget build(BuildContext context) {
    // Create a mini-app layout to demonstrate the AppBar
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text('${index + 1}'),
              ),
              title: Text('Item ${index + 1}'),
              subtitle: Text('Description for item ${index + 1}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    if (component.id.contains('tabbar')) {
      return AppBar(
        title: const Text('Example App'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            color: Colors.blue,
            child: const TabBar(
              tabs: [
                Tab(text: 'Home'),
                Tab(text: 'Profile'),
                Tab(text: 'Settings'),
              ],
              isScrollable: false,
            ),
          ),
        ),
      );
    } else {
      return AppBar(
        title: const Text('Example App'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      );
    }
  }
}
