import 'package:flutter/material.dart';

import '/components/shimmers/shimmer.dart';

class VerticalAddressShimmer extends StatelessWidget {
  const VerticalAddressShimmer({super.key, this.itemCount = 5});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return const AddressTileShimmer();
      },
    );
  }
}

class AddressTileShimmer extends StatelessWidget {
  const AddressTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! Left: Circle icon
          const TShimmerEffect(width: 24, height: 24, radius: 24),
          const SizedBox(width: 16),

          //! Middle: Address Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TShimmerEffect(width: 150, height: 16, radius: 8),
                SizedBox(height: 8),
                TShimmerEffect(width: 120, height: 14, radius: 8),
                SizedBox(height: 8),
                TShimmerEffect(width: double.infinity, height: 14, radius: 8),
              ],
            ),
          ),
          const SizedBox(width: 16),

          //! Right: Edit and Delete Icons
          Column(
            children: const [
              TShimmerEffect(width: 42, height: 42, radius: 42),
              SizedBox(height: 16),
              TShimmerEffect(width: 42, height: 42, radius: 42),
            ],
          ),
        ],
      ),
    );
  }
}
