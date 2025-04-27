import 'package:flutter/material.dart';

import '/core/constants/colors.dart';
import '../texts/t_brand_title_text.dart';

/// A widget that displays an image with text below it in a vertical arrangement.
class TVerticalImageAndText extends StatelessWidget {
  /// Constructor for [TVerticalImageAndText].
  const TVerticalImageAndText({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
    this.backgroundColor,
    this.isNetworkImage = true,
    this.textColor = TColors.white,
    this.categoryIcon,
  });

  /// The image asset path or URL.
  final String image;

  /// The text to be displayed below the image.
  final String title;

  /// The color of the text.
  final Color textColor;

  /// Flag indicating whether the image is loaded from the network.
  final bool isNetworkImage;

  /// The background color of the widget.
  final Color? backgroundColor;

  /// Callback function when the widget is tapped.
  final void Function()? onTap;

  /// Icon that represent a category
  final IconData? categoryIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 16.0),
        child: Column(
          children: [
            // TCircularImage(
            //   image: image,
            //   fit: BoxFit.fitWidth,
            //   padding: TSizes.sm * 1.4,
            //   isNetworkImage: isNetworkImage,
            //   backgroundColor: backgroundColor,
            //   overlayColor: THelperFunctions.isDarkMode(context) ? TColors.light : TColors.dark,
            // ),
            CircleAvatar(
              radius: 30,
              backgroundColor: backgroundColor?.withValues(alpha: 0.7),
              child: Center(
                child: Icon(categoryIcon, color: Colors.white, size: 30),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 55,
              child: TBrandTitleText(title: title, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
