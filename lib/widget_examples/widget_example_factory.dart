import 'package:flutter/material.dart';
import '../models/component_model.dart';
import '../models/flutter_category.dart';
import 'appbar_examples.dart';
import 'button_examples.dart';
import 'chip_examples.dart';
import 'icon_examples.dart';
import 'image_examples.dart';
import 'list_tile_examples.dart';
import 'shimmer_examples.dart';
import 'text_examples.dart';
import 'textfield_examples.dart';
import 'widget_example_base.dart';

/// Factory class to create widget examples based on component category
class WidgetExampleFactory {
  /// Create an example widget for a component
  static Widget createExample(ComponentModel component) {
    switch (component.category) {
      case FlutterCategory.appBar:
        return AppBarExample(component: component);

      case FlutterCategory.button:
        return ButtonExample(component: component);

      case FlutterCategory.textField:
        return TextFieldExample(component: component);

      case FlutterCategory.listTile:
        return ListTileExample(component: component);

      case FlutterCategory.image:
        return ImageExample(component: component);

      case FlutterCategory.text:
        return TextExample(component: component);

      case FlutterCategory.chip:
        return ChipExample(component: component);

      case FlutterCategory.icon:
        return IconExample(component: component);

      case FlutterCategory.shimmer:
        return ShimmerExample(component: component);

      // For other categories, use the default example
      default:
        return DefaultWidgetExample(component: component);
    }
  }
}
