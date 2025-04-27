import 'package:flutter/material.dart';
import '../models/component_model.dart';
import 'widget_example_base.dart';

/// Example implementation for ListTile widgets
class ListTileExample extends WidgetExampleBase {
  const ListTileExample({super.key, required super.component});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // App bar
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue,
            child: const Row(
              children: [
                Icon(Icons.settings, color: Colors.white),
                SizedBox(width: 16),
                Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // List of settings
          _buildListTile(
            Icons.person,
            'Account',
            'Privacy, security, change email',
            Colors.blue,
          ),
          
          const Divider(height: 1),
          
          _wrapWithBuilder(component.createWidget()),
          
          const Divider(height: 1),
          
          _buildListTile(
            Icons.notifications,
            'Notifications',
            'Message, app, and email notifications',
            Colors.orange,
          ),
          
          const Divider(height: 1),
          
          _buildListTile(
            Icons.help,
            'Help & Support',
            'FAQ, contact us, privacy policy',
            Colors.green,
          ),
        ],
      ),
    );
  }
  
  Widget _buildListTile(IconData icon, String title, String subtitle, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, color: color),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
  
  Widget _wrapWithBuilder(Widget listTile) {
    // If the list tile doesn't have proper styling, replace it with a more visible example
    if (listTile is! ListTile) {
      return _buildListTile(
        Icons.language,
        'Language',
        'Change app language',
        Colors.purple,
      );
    }
    
    return listTile;
  }
}
