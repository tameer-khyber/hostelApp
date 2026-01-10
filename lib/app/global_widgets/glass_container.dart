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
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: borderRadius ?? BorderRadius.circular(30),
            border: border ?? Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: child,
        ),
      ),
    );
  }
}
