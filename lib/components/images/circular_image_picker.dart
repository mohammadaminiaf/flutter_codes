import 'package:flutter/material.dart';

class CircularImagePicker extends StatelessWidget {
  const CircularImagePicker({
    super.key,
    this.radius = 56,
    this.overlayColor,
    this.backgroundColor,
    this.image,
    this.defaultIcon = Icons.person,
    this.loadingWidget,
    this.errorIcon = Icons.error_outline,
    this.onPressed,
    this.fit = BoxFit.cover,
    this.padding = 16,
    this.isNetworkImage = false,
  });

  final double radius;
  final Color? overlayColor;
  final Color? backgroundColor;
  final String? image;
  final IconData defaultIcon;
  final Widget? loadingWidget;
  final IconData errorIcon;
  final VoidCallback? onPressed;
  final BoxFit fit;
  final double padding;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color resolvedBackground = backgroundColor ?? 
        (isDarkMode ? Colors.black : Colors.white);
    final Widget errorWidget = Icon(errorIcon, 
        size: radius * 0.6, color: Colors.grey[600]);

    Widget imageContent = image == null 
        ? Icon(defaultIcon, size: radius * 0.6, color: Colors.grey[600])
        : Image(
            image: isNetworkImage 
                ? NetworkImage(image!) 
                : AssetImage(image!) as ImageProvider,
            fit: fit,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return loadingWidget ?? 
                  CircularProgressIndicator(
                    value: progress.expectedTotalBytes != null 
                        ? progress.cumulativeBytesLoaded / 
                          progress.expectedTotalBytes!
                        : null,
                    strokeWidth: 2,
                  );
            },
            errorBuilder: (context, error, stack) => errorWidget,
          );

    return InkWell(
      onTap: onPressed,
      child: CircleAvatar(
        radius: radius / 2,
        backgroundColor: resolvedBackground,
        child: Stack(
          children: [
            ClipOval(
              child: SizedBox(
                width: radius,
                height: radius,
                child: imageContent,
              ),
            ),
            if (overlayColor != null)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: overlayColor!.withOpacity(0.4),
                ),
              ),
          ],
        ),
      ),
    );
  }
}