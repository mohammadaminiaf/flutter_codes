import 'package:flutter/material.dart';

class RetryView extends StatelessWidget {
  final VoidCallback? onRetry;
  final String? message;

  const RetryView({super.key, this.onRetry, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded, size: 50, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            message ?? 'No internet connection',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(minimumSize: const Size(120, 40)),
            child: const Text('Retry'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
