import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tag chip for amenities, filters, categories
class TagChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool showDeleteIcon;
  final VoidCallback? onDelete;

  const TagChip({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.isSelected = false,
    this.onTap,
    this.showDeleteIcon = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? 
        (isSelected 
            ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
            : Colors.grey.shade200);
    
    final txtColor = textColor ?? 
        (isSelected 
            ? Theme.of(context).colorScheme.primary
            : Colors.black87);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: isSelected 
              ? Border.all(color: Theme.of(context).colorScheme.primary)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: txtColor),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: txtColor,
              ),
            ),
            if (showDeleteIcon) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onDelete,
                child: Icon(Icons.close, size: 16, color: txtColor),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
