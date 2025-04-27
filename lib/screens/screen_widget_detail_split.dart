import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_model.dart';
import '../providers/component_riverpod_provider.dart';
import '../screens/screen_desktop_layout.dart';
import '../services/source_code_service.dart';
import '../widgets/component_preview_wrapper.dart';

class ScreenWidgetDetailSplit extends ConsumerStatefulWidget {
  final String componentId;

  const ScreenWidgetDetailSplit({super.key, required this.componentId});

  @override
  ConsumerState<ScreenWidgetDetailSplit> createState() =>
      _ScreenWidgetDetailSplitState();
}

class _ScreenWidgetDetailSplitState
    extends ConsumerState<ScreenWidgetDetailSplit> {
  String _sourceCode = '';
  bool _isLoadingSourceCode = true;

  @override
  void initState() {
    super.initState();
    _loadSourceCode();
  }

  @override
  void didUpdateWidget(ScreenWidgetDetailSplit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.componentId != widget.componentId) {
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
      return const Center(child: Text('Component not found'));
    }

    return Column(
      children: [
        // Header with back button and component name
        _buildHeader(context, component),

        // Main content with split view
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Use a row for wide screens, column for narrow screens
              final isWideScreen = constraints.maxWidth > 900;

              if (isWideScreen) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Widget preview (left half)
                    Expanded(child: _buildPreviewSection(component)),

                    // Vertical divider
                    const VerticalDivider(width: 1),

                    // Source code (right half)
                    Expanded(child: _buildSourceCodeSection()),
                  ],
                );
              } else {
                return Column(
                  children: [
                    // Widget preview (top half)
                    Expanded(child: _buildPreviewSection(component)),

                    // Horizontal divider
                    const Divider(height: 1),

                    // Source code (bottom half)
                    Expanded(child: _buildSourceCodeSection()),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, ComponentModel component) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Clear the selected component ID to go back to the list view
              ref.read(selectedComponentIdProvider.notifier).state = null;
            },
          ),
          const SizedBox(width: 16.0),

          // Component name and category
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  component.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  component.category.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewSection(ComponentModel component) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Preview', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8.0),
          Text(
            component.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24.0),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ComponentPreviewWrapper(component: component),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceCodeSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Source Code',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.copy),
                label: const Text('Copy Code'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _sourceCode));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Code copied to clipboard')),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child:
                _isLoadingSourceCode
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: SingleChildScrollView(
                        child: HighlightView(
                          _sourceCode,
                          language: 'dart',
                          theme: githubTheme,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 14,
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
