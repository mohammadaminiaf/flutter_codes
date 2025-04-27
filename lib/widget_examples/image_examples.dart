import 'package:flutter/material.dart';
import '../models/component_model.dart';
import 'widget_example_base.dart';

/// Example implementation for Image widgets
class ImageExample extends WidgetExampleBase {
  const ImageExample({super.key, required super.component});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          const Text(
            'User Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // Profile image and info
          Row(
            children: [
              // Profile image
              _wrapWithBuilder(component.createWidget()),
              const SizedBox(width: 16),
              
              // User info
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Software Developer',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          'New York, USA',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat('Posts', '248'),
              _buildStat('Followers', '12.4K'),
              _buildStat('Following', '142'),
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
                  ),
                  child: const Text('Edit Profile'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Share Profile'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
  
  Widget _wrapWithBuilder(Widget image) {
    // If the image widget doesn't have proper styling, replace it with a more visible example
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 80,
        height: 80,
        color: Colors.blue.shade100,
        child: image is Image 
            ? image 
            : const Icon(Icons.person, size: 40, color: Colors.blue),
      ),
    );
  }
}
