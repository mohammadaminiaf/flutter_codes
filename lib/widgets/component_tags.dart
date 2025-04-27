import 'package:flutter/material.dart';

/// A widget to display component tags
class ComponentTags extends StatelessWidget {
  final List<String> tags;
  final Function(String)? onTagTap;

  const ComponentTags({
    super.key,
    required this.tags,
    this.onTagTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: tags.map((tag) {
        return InkWell(
          onTap: onTagTap != null ? () => onTagTap!(tag) : null,
          child: Chip(
            label: Text(tag),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: 12.0,
            ),
          ),
        );
      }).toList(),
    );
  }
}
