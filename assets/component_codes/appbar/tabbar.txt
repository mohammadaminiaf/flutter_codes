import 'package:flutter/material.dart';


/// A custom tab bar widget with customizable appearance.
class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// Default constructor for the TTabBar.
  ///
  /// Parameters:
  ///   - tabs: List of widgets representing the tabs.
  const TTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Material(
      color: dark ? Colors.black : Colors.white, // Background color of the tab bar
      child: TabBar(
        tabs: tabs, // List of tabs
        isScrollable: true, // Enable scrollable tabs
        indicatorColor: const Color(0xFF4b68ff), // Color of the tab indicator
        labelColor: dark ? Colors.white : const Color(0xFF4b68ff), // Color of the selected tab label
        unselectedLabelColor: const Color(0xFF939393), // Color of unselected tab labels
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); // Preferred size of the tab bar
}