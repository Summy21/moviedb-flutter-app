import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviedb_flutter_app/core/constants/api_constants.dart';
import 'package:moviedb_flutter_app/features/media/presentation/widgets/rating_badge.dart';

/// Reusable card widget for displaying a movie or TV show in a grid.
///
/// Shows the poster image with a [RatingBadge] overlay, title,
/// and year below. Tapping triggers [onTap].
///
/// The [heroTag] enables Hero animations between this card
/// and the detail screen poster.
class MediaCard extends StatelessWidget {
  const MediaCard({
    super.key,
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.year,
    required this.onTap,
    required this.heroTag,
  });

  final int id;
  final String title;
  final String? posterPath;
  final double voteAverage;
  final String year;
  final VoidCallback onTap;

  /// Unique tag for Hero animation — must match the tag in DetailPage.
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster with rating badge
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Poster image
                    Hero(
                      tag: heroTag,
                      child: posterPath != null
                          ? CachedNetworkImage(
                              imageUrl: ApiConstants.imageUrl(posterPath),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => _placeholder(),
                              errorWidget: (context, url, error) =>
                                  _placeholder(),
                            )
                          : _placeholder(),
                    ),
                    // Rating badge — top right corner
                    Positioned(
                      top: 6,
                      right: 6,
                      child: RatingBadge(voteAverage: voteAverage),
                    ),
                  ],
                ),
              ),
            ),

            // Title and year
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    year,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Placeholder shown while image loads or if poster is null.
  Widget _placeholder() {
    return Container(
      color: const Color(0xFF0F3460),
      child: const Center(
        child: Icon(Icons.movie_outlined, color: Colors.white24, size: 32),
      ),
    );
  }
}