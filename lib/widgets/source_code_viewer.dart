import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class SourceCodeViewer extends StatefulWidget {
  final String path;
  const SourceCodeViewer({super.key, required this.path});

  @override
  State<SourceCodeViewer> createState() => _SourceCodeViewerState();
}

class _SourceCodeViewerState extends State<SourceCodeViewer> {
  /// Load the source code from the assets
  Future<String> _loadSourceCode(BuildContext context) async {
    try {
      // Try to load the source code from the assets
      return await DefaultAssetBundle.of(
        context,
      ).loadString('assets/component_codes/${widget.path}');
    } catch (e) {
      // If there's an error, throw it to be caught by the FutureBuilder
      throw Exception('Failed to load source code: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadSourceCode(context),
      builder: (context, AsyncSnapshot<String> snapshot) {
        // Handle error and loading cases
        if (snapshot.hasError) {
          return Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Error Loading Source Code',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Path: assets/component_codes/${widget.path}'),
                  const SizedBox(height: 8),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Refresh the source code
                      setState(() {});
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final codeString = snapshot.data ?? '';

        return Expanded(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: SingleChildScrollView(
                  child: HighlightView(
                    codeString,
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
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: codeString));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Code copied to clipboard')),
                    );
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
