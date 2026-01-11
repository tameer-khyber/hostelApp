import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Border? border;

  const GlassContainer({
    Key? key,
    required this.child,
    this.blur = 15,
    this.opacity = 0.2,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: isDark 
                ? const Color(0xFF1E1E1E).withOpacity(0.6) // Darker, more solid for legibility
                : Colors.white.withOpacity(opacity),
            borderRadius: borderRadius ?? BorderRadius.circular(30),
            border: border ?? Border.all(
              color: isDark 
                  ? Colors.white.withOpacity(0.05) // Very subtle border in dark mode
                  : Colors.white.withOpacity(0.3)
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
