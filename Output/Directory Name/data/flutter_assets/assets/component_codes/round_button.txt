import 'package:flutter/material.dart';
import 'package:flutter_codes/core/constants/colors.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double borderRadius;
  final double elevation;
  final double padding;
  final TextStyle? textStyle;
  final Gradient? gradient;
  final double width;
  final double height;
  final double borderWidth;

  const RoundButton({
    super.key,
    this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius = 28.0,
    this.elevation = 4.0,
    this.padding = 16.0,
    this.textStyle,
    this.gradient,
    this.width = double.infinity,
    this.height = 25.0,
    this.borderWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Color defaultColor =
        isOutlined ? Colors.transparent : TColors.primary;
    final Color defaultTextColor =
        isOutlined ? theme.colorScheme.primary : Colors.white;

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        elevation: isOutlined ? 0 : elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color:
                  isOutlined
                      ? Colors.transparent
                      : backgroundColor ?? defaultColor,
              gradient: !isOutlined ? gradient : null,
              border:
                  isOutlined
                      ? Border.all(
                        color: borderColor ?? defaultTextColor,
                        width: borderWidth,
                      )
                      : null,
            ),
            child: Stack(
              children: [
                AnimatedOpacity(
                  opacity: isLoading ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Center(
                    child: Text(
                      text,
                      style:
                          textStyle?.copyWith(
                            color: textColor ?? defaultTextColor,
                          ) ??
                          TextStyle(
                            color: textColor ?? defaultTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                if (isLoading)
                  const Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
