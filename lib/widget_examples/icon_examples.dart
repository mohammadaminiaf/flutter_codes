import 'package:flutter/material.dart';
import '../models/component_model.dart';
import 'widget_example_base.dart';

/// Example implementation for Icon widgets
class IconExample extends WidgetExampleBase {
  const IconExample({super.key, required super.component});

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
              'Smart Home Dashboard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Quick actions
            const Text(
              'Quick Actions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickAction(
                  Icons.lightbulb_outline,
                  'Lights',
                  Colors.amber,
                ),
                _buildQuickAction(Icons.thermostat, 'Thermostat', Colors.red),
                _wrapWithBuilder(
                  component.createWidget(),
                  'Security',
                  Colors.blue,
                ),
                _buildQuickAction(Icons.tv, 'TV', Colors.purple),
              ],
            ),
            const SizedBox(height: 24),

            // Rooms section
            const Text(
              'Rooms',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildRoomItem('Living Room', '72°F', Icons.living, 4),
                  const Divider(),
                  _buildRoomItem('Kitchen', '74°F', Icons.kitchen, 2),
                  const Divider(),
                  _buildRoomItem('Bedroom', '70°F', Icons.bed, 3),
                  const Divider(),
                  _buildRoomItem('Bathroom', '73°F', Icons.bathtub, 1),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Energy usage
            const Text(
              'Energy Usage',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.bolt,
                      color: Colors.green,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '24.5 kWh',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Today\'s usage (12% less than yesterday)',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildRoomItem(String room, String temp, IconData icon, int devices) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(room, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(
                  '$devices devices',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(temp, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _wrapWithBuilder(Widget icon, String label, Color color) {
    // If the icon widget doesn't have proper styling, replace it with a more visible example
    if (icon is! Icon) {
      return _buildQuickAction(Icons.security, label, color);
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: icon,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
