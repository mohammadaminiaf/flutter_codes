import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import '../components/appbar/appbar.dart';
import '../components/buttons/round_button.dart';
import '../components/chips/rounded_choice_chips.dart';
import '../components/custom_shapes/containers/circular_container.dart';
import '../components/icons/t_circular_icon.dart';
import '../components/images/circular_image_picker.dart';
import '../components/list_tiles/settings_menu_tile.dart';
import '../components/list_tiles/user_profile_tile.dart';
import '../components/otp_input/otp_textfield.dart';
import '../components/textfields/password_textfield.dart';
import '../components/texts/section_heading.dart';
import '../components/texts/t_brand_title_text.dart';

import '../components/texts/t_product_price_text.dart';
import '../components/texts/t_product_title_text.dart';
import '../components/views/retry_view.dart';

/// A factory for creating component widgets dynamically
class DynamicComponentFactory {
  DynamicComponentFactory._(); // Private constructor to prevent instantiation

  /// Create a widget for a component
  static Widget createWidget(String componentId) {
    debugPrint('Creating widget for component ID: $componentId');

    // Extract the component path from the ID
    final componentPath = componentId.replaceAll('_', '/');
    debugPrint('Component path: $componentPath');

    // Extract the component name from the path
    final componentName = path.basename(componentPath);
    debugPrint('Component name: $componentName');

    // Create the widget based on the component ID
    switch (componentId) {
      // AppBar components
      case 'appbar_appbar':
        return TAppBar(
          title: const Text('App Bar Title'),
          showBackArrow: true,
          centerTitle: false,
        );

      case 'appbar_tabbar':
        return const TabBar(
          tabs: [Tab(text: 'Tab 1'), Tab(text: 'Tab 2'), Tab(text: 'Tab 3')],
        );

      // Button components
      case 'buttons_round_button':
        return RoundButton(
          text: 'Press Me',
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          onPressed: () {},
        );

      // Chip components
      case 'chips_rounded_choice_chips':
        return TChoiceChip(
          text: 'Choice Chip',
          selected: false,
          onSelected: (value) {},
        );

      // Container components
      case 'custom_shapes_containers_circular_container':
        return TCircularContainer(
          width: 150,
          height: 150,
          radius: 20,
          showBorder: true,
          backgroundColor: Colors.white,
          borderColor: Colors.grey,
          child: const Center(child: Text('Container Content')),
        );

      // Curved edges components
      case 'custom_shapes_curved_edges_curved_edges':
      case 'custom_shapes_curved_edges_curved_edges_widget':
        return Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Text('Curved Edge', style: TextStyle(color: Colors.white)),
          ),
        );

      // Icon components
      case 'icons_t_circular_icon':
        return TCircularIcon(icon: Icons.home, onPressed: () {});

      // Image components
      case 'images_circular_image_picker':
        return CircularImagePicker(radius: 100.0, showEditIcon: true);

      // Image text components
      case 'image_text_image_text_vertical':
        return Column(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.grey.shade300,
              child: const Icon(Icons.image),
            ),
            const SizedBox(height: 8),
            const Text('Image with Text'),
          ],
        );

      // Layout components
      case 'layouts_grid_layout':
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          children: List.generate(
            4,
            (index) => Container(
              margin: const EdgeInsets.all(8),
              color: Colors.blue.shade100,
              child: Center(child: Text('Item $index')),
            ),
          ),
        );

      // List tile components
      case 'list_tiles_settings_menu_tile':
        return TSettingsMenuTile(
          icon: Icons.settings,
          title: 'Settings',
          subTitle: 'Configure app settings',
          onTap: () {},
        );

      case 'list_tiles_user_profile_tile':
        return TUserProfileTile(onPressed: () {});

      // OTP components
      case 'otp_input_otp_textfield':
      case 'otp_textfield_otp_textfield':
        return OTPTextField(
          length: 4,
          spacing: 8.0,
          styleType: StyleType.bordered,
          borderColor: Colors.grey,
          focusBorderColor: Colors.blue,
          borderWidth: 2.0,
        );

      // Shimmer components
      case 'shimmers_boxes_shimmer':
      case 'shimmers_brands_shimmer':
      case 'shimmers_category_shimmer':
      case 'shimmers_horizontal_product_shimmer':
      case 'shimmers_list_tile_shimmer':
      case 'shimmers_product_details_shimmer':
      case 'shimmers_search_category_shimmer':
      case 'shimmers_shimmer':
      case 'shimmers_vertical_address_shimmer':
      case 'shimmers_vertical_product_shimmer':
        return Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(child: Text('Shimmer Effect')),
        );

      // Text field components
      case 'textfields_password_textfield':
      case 'text_fields_password_textfield':
        return PasswordTextfield(
          labelText: 'Password',
          hintText: 'Enter your password',
        );

      // Text components
      case 'texts_section_heading':
        return TSectionHeading(
          title: 'Section Title',
          buttonTitle: 'See All',
          onPressed: () {},
        );

      case 'texts_t_brand_title_text':
        return TBrandTitleText(title: 'Brand Title');

      case 'texts_t_brand_title_text_with_verified_icon':
        return const Text('Brand Title with Verified Icon');

      case 'texts_t_product_price_text':
        return TProductPriceText(price: '99.99');

      case 'texts_t_product_title_text':
        return TProductTitleText(title: 'Product Title');

      // View components
      case 'views_retry_view':
        return RetryView(onRetry: () {});

      // Default case
      default:
        debugPrint(
          'No widget implementation found for component: $componentName',
        );
        debugPrint('Component ID: $componentId');
        debugPrint('Component path: $componentPath');

        // Return a more informative widget
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.warning, color: Colors.orange, size: 48),
              const SizedBox(height: 16),
              Text(
                'No preview available for "$componentName"',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('ID: $componentId', style: const TextStyle(fontSize: 12)),
              Text(
                'Path: $componentPath',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
    }
  }
}
