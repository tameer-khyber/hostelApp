import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Social login button (Google, Facebook, etc.)
class SocialButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final Color? backgroundColor;
  final Color textColor;
  final VoidCallback? onPressed;
  final double? width;
  final double height;

  const SocialButton({
    super.key,
    required this.text,
    required this.icon,
    required this.iconColor,
    this.backgroundColor,
    this.textColor = const Color(0xFF37474F),
    this.onPressed,
    this.width,
    this.height = 55,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: backgroundColor == null 
            ? Border.all(color: Colors.grey.shade200) 
            : null,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
