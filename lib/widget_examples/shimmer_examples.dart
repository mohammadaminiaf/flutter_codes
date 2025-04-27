import 'package:flutter/material.dart';
import '../models/component_model.dart';
import 'widget_example_base.dart';

/// Example implementation for Shimmer widgets
class ShimmerExample extends WidgetExampleBase {
  const ShimmerExample({super.key, required super.component});
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Loading States'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'List Shimmer'),
              Tab(text: 'Grid Shimmer'),
              Tab(text: 'Detail Shimmer'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildListShimmerExample(),
            _buildGridShimmerExample(),
            _buildDetailShimmerExample(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildListShimmerExample() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar shimmer
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(height: 24),
          
          // Category shimmer
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (_, __) => Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 60,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // List items shimmer
          for (int i = 0; i < 10; i++) ...[
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 150,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (i < 9) const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
  
  Widget _buildGridShimmerExample() {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 10,
      itemBuilder: (_, __) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image shimmer
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Product title shimmer
          Container(
            width: double.infinity,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          
          // Product price shimmer
          Container(
            width: 80,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          
          // Product rating shimmer
          Row(
            children: [
              Container(
                width: 60,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 40,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailShimmerExample() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main product image shimmer
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 16),
          
          // Small product images shimmer
          Row(
            children: [
              for (int i = 0; i < 4; i++) ...[
                Expanded(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                if (i < 3) const SizedBox(width: 8),
              ],
            ],
          ),
          const SizedBox(height: 24),
          
          // Product title shimmer
          Container(
            width: double.infinity,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 16),
          
          // Price and rating shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                width: 120,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Description title shimmer
          Container(
            width: 120,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          
          // Description content shimmer
          for (int i = 0; i < 4; i++) ...[
            Container(
              width: double.infinity,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 24),
          
          // Specifications title shimmer
          Container(
            width: 150,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 16),
          
          // Specifications content shimmer
          for (int i = 0; i < 3; i++) ...[
            Row(
              children: [
                Container(
                  width: 100,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 24),
          
          // Add to cart button shimmer
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
