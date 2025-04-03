import 'package:flutter/material.dart';

import '/models/component_model.dart';
import '/widgets/component_preview.dart';
import '/widgets/source_code_viewer.dart';
import '/widgets/customization_panel.dart';

class ScreenComponentDetails extends StatefulWidget {
  final ComponentModel component;

  const ScreenComponentDetails({super.key, required this.component});

  @override
  State<ScreenComponentDetails> createState() => _ScreenComponentDetailsState();
}

class _ScreenComponentDetailsState extends State<ScreenComponentDetails> with SingleTickerProviderStateMixin {
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
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(child: ComponentPreview(component: widget.component)),
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
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(child: ComponentPreview(component: widget.component)),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: CustomizationPanel(component: widget.component),
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
                Text('Source Code:', style: Theme.of(context).textTheme.titleLarge),
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

