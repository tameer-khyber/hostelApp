import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Rating stars widget for display and input
class RatingStars extends StatelessWidget {
  final double rating;
  final int maxRating;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final bool readOnly;
  final void Function(double)? onRatingChanged;

  const RatingStars({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 20,
    this.activeColor = const Color(0xFFFFB74D),
    this.inactiveColor = const Color(0xFFE0E0E0),
    this.readOnly = true,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final starValue = index + 1;
        final fillAmount = (rating - index).clamp(0.0, 1.0);
        
        return GestureDetector(
          onTap: readOnly ? null : () => onRatingChanged?.call(starValue.toDouble()),
          child: Icon(
            fillAmount >= 1.0
                ? Icons.star
                : fillAmount > 0
                    ? Icons.star_half
                    : Icons.star_border,
            color: fillAmount > 0 ? activeColor : inactiveColor,
            size: size,
          ),
        );
      }),
    );
  }
}
