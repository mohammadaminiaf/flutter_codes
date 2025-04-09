import 'package:flutter/material.dart';

/// A wrapper widget that ensures all components have proper constraints
/// to prevent "Cannot hit test a render box with no size" errors
class ConstrainedComponentWrapper extends StatelessWidget {
  final Widget child;
  final double minWidth;
  final double minHeight;
  final double? maxWidth;
  final double? maxHeight;

  const ConstrainedComponentWrapper({
    super.key,
    required this.child,
    this.minWidth = 200,
    this.minHeight = 50,
    this.maxWidth,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
        minHeight: minHeight,
        maxWidth: maxWidth ?? double.infinity,
        maxHeight: maxHeight ?? double.infinity,
      ),
      child: child,
    );
  }
}
