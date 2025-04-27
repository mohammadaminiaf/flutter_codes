import 'package:flutter/material.dart';

// Define size constants locally to remove external dependency
class TSizes {
  static const double lg = 24.0;
}

class TCircularIcon extends StatelessWidget {
  /// A custom Circular Icon widget with a background color.
  ///
  /// Properties are:
  /// Container [width], [height], & [backgroundColor].
  ///
  /// Icon's [size], [color] & [onPressed]
  const TCircularIcon({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.size = TSizes.lg,
    this.onPressed,
    this.color,
    this.backgroundColor,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color:
            backgroundColor != null
                ? backgroundColor!
                : MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.black.withAlpha(230)
                : Colors.white.withAlpha(230),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}
