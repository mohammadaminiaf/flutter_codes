import 'package:flutter/material.dart';
import '../../models/component_definition.dart';
import '../../models/flutter_category.dart';
import '../../models/customization_models/common_customization_model.dart';
import '../carousels/carousel_view.dart';

/// Definitions for carousel components
final List<ComponentDefinition> carouselComponents = [
  ComponentDefinition(
    id: 'carousels_carousel_view',
    name: 'Custom Carousel',
    description: 'A customizable image carousel with smooth animations',
    category: FlutterCategory.carousel,
    sourceCodePath: 'carousels/carousel_view.txt',
    defaultCustomization: CommonCustomizationModel(
      backgroundColor: Colors.white,
      primaryColor: Colors.blue,
    ),
    builder: (customization) {
      return const CustomCarouselFB2();
    },
    tags: ['carousel', 'slider', 'image', 'gallery'],
  ),
];
