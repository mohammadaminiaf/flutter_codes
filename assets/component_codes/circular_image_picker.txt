import 'package:flutter/material.dart';

class CircularImagePicker extends StatelessWidget {
  const CircularImagePicker({
    super.key,
    required this.radius,
    this.image,
    this.onPressed,
    this.fit = BoxFit.cover,
    this.showEditIcon = false,
    this.editIconSize,
    this.backgroundColor,
    this.overlayColor,
    this.defaultIcon = Icons.person,
    this.errorIcon = Icons.error_outline,
    this.isNetworkImage = false,
  });

  final double radius;
  final String? image;
  final VoidCallback? onPressed;
  final BoxFit fit;
  final bool showEditIcon;
  final double? editIconSize;
  final Color? backgroundColor;
  final Color? overlayColor;
  final IconData defaultIcon;
  final IconData errorIcon;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    // Resolve colors with fallbacks
    final resolvedBackground =
        backgroundColor ??
        (isDarkMode ? colorScheme.surface : colorScheme.background);
    final resolvedEditIconColor = colorScheme.onPrimary;
    final editIconBackground = colorScheme.primary;

    return SizedBox(
      width: radius,
      height: radius,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main circular avatar
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: resolvedBackground,
            ),
            child: ClipOval(
              child: SizedBox(
                width: radius,
                height: radius,
                child: _buildImageContent(),
              ),
            ),
          ),

          // Overlay (if provided)
          if (overlayColor != null)
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: overlayColor!.withAlpha(100),
              ),
            ),

          // Edit icon
          if (showEditIcon)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: editIconBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: resolvedBackground, width: 2),
                ),
                child: Icon(
                  Icons.edit,
                  size: editIconSize ?? radius / 5,
                  color: resolvedEditIconColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageContent() {
    if (image == null) {
      return Icon(defaultIcon, size: radius * 0.6, color: Colors.grey[600]);
    }

    return Image(
      image:
          isNetworkImage
              ? NetworkImage(image!)
              : AssetImage(image!) as ImageProvider,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value:
                progress.expectedTotalBytes != null
                    ? progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!
                    : null,
            strokeWidth: 2,
          ),
        );
      },
      errorBuilder:
          (context, error, stack) =>
              Icon(errorIcon, size: radius * 0.6, color: Colors.grey[600]),
    );
  }
}
