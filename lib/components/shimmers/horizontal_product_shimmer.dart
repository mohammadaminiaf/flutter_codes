import 'package:flutter/material.dart';

import 'shimmer.dart';

class THorizontalProductShimmer extends StatelessWidget {
  const THorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      height: 120,
      child: ListView.separated(
        itemCount: itemCount,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder:
            (_, __) => const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Image
                TShimmerEffect(width: 120, height: 120),
                SizedBox(width: 16),

                /// Text
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 8),
                    TShimmerEffect(width: 160, height: 15),
                    SizedBox(height: 8),
                    TShimmerEffect(width: 110, height: 15),
                    SizedBox(height: 8),
                    TShimmerEffect(width: 80, height: 15),
                    Spacer(),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
