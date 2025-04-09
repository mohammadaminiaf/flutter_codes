import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/component_model.dart';
import '/widgets/component_preview_riverpod.dart';
import '/widgets/source_code_viewer.dart';
import '/widgets/customization_panel_riverpod.dart';

class ScreenComponentDetailsRiverpod extends ConsumerStatefulWidget {
  final ComponentModel component;

  const ScreenComponentDetailsRiverpod({super.key, required this.component});

  @override
  ConsumerState<ScreenComponentDetailsRiverpod> createState() =>
      _ScreenComponentDetailsRiverpodState();
}

class _ScreenComponentDetailsRiverpodState
    extends ConsumerState<ScreenComponentDetailsRiverpod>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.component.name),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Preview'),
            Tab(text: 'Customize'),
            Tab(text: 'Source Code'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Preview Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Component description
                Text(
                  widget.component.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),

                // Component preview
                Text('Preview:', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  constraints: const BoxConstraints(
                    minHeight: 150,
                    minWidth: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(
                    child: ComponentPreviewRiverpod(
                      component: widget.component,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Customize Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customize Component:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  constraints: const BoxConstraints(
                    minHeight: 150,
                    minWidth: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(
                    child: ComponentPreviewRiverpod(
                      component: widget.component,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: CustomizationPanelRiverpod(
                    component: widget.component,
                  ),
                ),
              ],
            ),
          ),

          // Source Code Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Source Code:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: SourceCodeViewer(path: widget.component.codeFilePath),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
