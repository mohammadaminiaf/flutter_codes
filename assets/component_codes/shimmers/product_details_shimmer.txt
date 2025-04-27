import 'package:flutter/material.dart';
import 'shimmer.dart';

class TProductDetailsShimmer extends StatelessWidget {
  const TProductDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Image Shimmer
          const TShimmerEffect(width: double.infinity, height: 400),

          const SizedBox(height: 16),

          // Three Small Images Row
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                for (int i = 0; i < 3; i++) ...[
                  const TShimmerEffect(width: 80, height: 80),
                  if (i < 2) const SizedBox(width: 16),
                ],
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Rating and Share Button Row
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TShimmerEffect(width: 100, height: 20),
                const TShimmerEffect(width: 20, height: 20),
              ],
            ),
          ),

          // Title
          const Padding(
            padding: EdgeInsets.all(24),
            child: TShimmerEffect(width: double.infinity, height: 30),
          ),

          // Brand
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const TShimmerEffect(width: 40, height: 40, radius: 20),
                const SizedBox(width: 16),
                const TShimmerEffect(width: 120, height: 20),
              ],
            ),
          ),

          // Description
          const Padding(
            padding: EdgeInsets.all(24),
            child: TShimmerEffect(width: double.infinity, height: 60),
          ),

          // Checkout Button
          const Padding(
            padding: EdgeInsets.all(24),
            child: TShimmerEffect(width: double.infinity, height: 50),
          ),
        ],
      ),
    );
  }
}
