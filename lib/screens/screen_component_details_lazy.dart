import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_model.dart';
import '../providers/component_riverpod_provider.dart';
import '../services/source_code_service.dart';
import '../widgets/component_preview_riverpod.dart';
import '../widgets/component_tags.dart';
import '../widgets/customization_panel_riverpod.dart';

/// A screen to display component details with lazy loading of source code
class ScreenComponentDetailsLazy extends ConsumerStatefulWidget {
  final String componentId;

  const ScreenComponentDetailsLazy({super.key, required this.componentId});

  @override
  ConsumerState<ScreenComponentDetailsLazy> createState() =>
      _ScreenComponentDetailsLazyState();
}

class _ScreenComponentDetailsLazyState
    extends ConsumerState<ScreenComponentDetailsLazy>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _sourceCode;
  bool _isLoadingSourceCode = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    // Load source code when the source code tab is selected
    if (_tabController.index == 2 &&
        _sourceCode == null &&
        !_isLoadingSourceCode) {
      _loadSourceCode();
    }
  }

  Future<void> _loadSourceCode() async {
    setState(() {
      _isLoadingSourceCode = true;
    });

    final component = ref.read(componentByIdProvider(widget.componentId));
    if (component != null) {
      try {
        final sourceCode = await SourceCodeService.loadSourceCode(
          component.codeFilePath,
        );
        setState(() {
          _sourceCode = sourceCode;
          _isLoadingSourceCode = false;
        });
      } catch (e) {
        setState(() {
          _sourceCode = 'Error loading source code: $e';
          _isLoadingSourceCode = false;
        });
      }
    } else {
      setState(() {
        _sourceCode = 'Component not found';
        _isLoadingSourceCode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final component = ref.watch(componentByIdProvider(widget.componentId));

    if (component == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Component Not Found')),
        body: const Center(
          child: Text('The requested component could not be found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(component.name),
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
          _buildPreviewTab(component),

          // Customize Tab
          _buildCustomizeTab(component),

          // Source Code Tab
          _buildSourceCodeTab(component),
        ],
      ),
    );
  }

  Widget _buildPreviewTab(ComponentModel component) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Component description
          Text(
            component.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),

          // Component tags
          if (component.tags.isNotEmpty) ...[
            Text('Tags:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ComponentTags(tags: component.tags),
            const SizedBox(height: 24),
          ],

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
              child: ComponentPreviewRiverpod(component: component),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomizeTab(ComponentModel component) {
    return Padding(
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
              child: ComponentPreviewRiverpod(component: component),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(child: CustomizationPanelRiverpod(component: component)),
        ],
      ),
    );
  }

  Widget _buildSourceCodeTab(ComponentModel component) {
    if (_isLoadingSourceCode) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_sourceCode == null) {
      return Center(
        child: ElevatedButton(
          onPressed: _loadSourceCode,
          child: const Text('Load Source Code'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Source Code:', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _sourceCode!,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
