import 'package:flutter/material.dart';
import 'widget_example_base.dart';

/// Example implementation for Chip widgets
class ChipExample extends WidgetExampleBase {
  const ChipExample({super.key, required super.component});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Filter Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Categories section
            const Text(
              'Categories',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildFilterChip('Electronics', true),
                _buildFilterChip('Clothing', false),
                _buildFilterChip('Home & Garden', false),
                _buildFilterChip('Sports', false),
                _buildFilterChip('Toys', false),
              ],
            ),
            const SizedBox(height: 24),

            // Price range section
            const Text(
              'Price Range',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildFilterChip('Under \$25', false),
                _buildFilterChip('\$25 - \$50', true),
                _buildFilterChip('\$50 - \$100', false),
                _buildFilterChip('\$100 - \$200', false),
                _buildFilterChip('Over \$200', false),
              ],
            ),
            const SizedBox(height: 24),

            // Brands section with our component
            const Text(
              'Brands',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _wrapWithBuilder(component.createWidget(), 'Apple', true),
                _buildFilterChip('Samsung', false),
                _buildFilterChip('Sony', false),
                _buildFilterChip('LG', false),
                _buildFilterChip('Dell', false),
              ],
            ),
            const SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Apply Filters'),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Clear All'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (value) {},
      backgroundColor: Colors.grey.shade200,
      selectedColor: Colors.blue.shade100,
      checkmarkColor: Colors.blue,
    );
  }

  Widget _wrapWithBuilder(Widget chip, String label, bool selected) {
    // If the chip widget doesn't have proper styling, replace it with a more visible example
    if (chip is! Chip && chip is! FilterChip && chip is! ChoiceChip) {
      return _buildFilterChip(label, selected);
    }

    return chip;
  }
}
