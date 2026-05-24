import 'package:flutter/material.dart';

/// Displays a star rating badge overlaid on media cards.
///
/// Shows a semi-transparent dark background with a gold star
/// and the vote average formatted to one decimal place.
class RatingBadge extends StatelessWidget {
  const RatingBadge({
    super.key,
    required this.voteAverage,
  });

  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, color: Color(0xFFF5C518), size: 12),
          const SizedBox(width: 3),
          Text(
            voteAverage.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}