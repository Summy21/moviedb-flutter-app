import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter_app/core/constants/api_constants.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/media_detail.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/detail_cubit.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/detail_state.dart';
import 'package:moviedb_flutter_app/features/media/presentation/widgets/error_view.dart';
import 'package:moviedb_flutter_app/injection_container.dart';

/// Detail screen for a movie or TV show.
///
/// Receives [id] and [isMovie] from the router extra.
/// Fetches full detail via [DetailCubit] on init.
/// Uses Hero animation on the poster to create a smooth
/// transition from the card in the grid.
class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.id, required this.isMovie});
  final int id;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = sl<DetailCubit>();
        if (isMovie) {
          cubit.fetchMovieDetail(id);
        } else {
          cubit.fetchTvShowDetail(id);
        }
        return cubit;
      },
      child: _DetailContent(id: id, isMovie: isMovie),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.id, required this.isMovie});

  final int id;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(color: Color(0xFFE50914)),
            ),
            loaded: (detail) => _DetailBody(detail: detail, isMovie: isMovie),
            error: (message) => Scaffold(
              backgroundColor: const Color(0xFF1A1A2E),
              appBar: AppBar(backgroundColor: const Color(0xFF1A1A2E)),
              body: ErrorView(
                message: message,
                onRetry: () => isMovie
                    ? context.read<DetailCubit>().fetchMovieDetail(id)
                    : context.read<DetailCubit>().fetchTvShowDetail(id),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Main body of the detail screen.
///
/// Layout:
/// 1. Backdrop image with gradient overlay and back button
/// 2. Poster + title row overlapping the backdrop bottom
/// 3. Stats row — rating, duration/seasons, status
/// 4. Genres chips
/// 5. Overview text
/// 6. Tagline accent box
class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.detail, required this.isMovie});

  final MediaDetail detail;
  final bool isMovie;

  /// Hero tag must match the one used in [MediaCard].
  String get _heroTag => isMovie ? 'movie_${detail.id}' : 'tv_${detail.id}';

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Backdrop with back button and gradient
        SliverAppBar(
          expandedHeight: 220,
          pinned: true,
          backgroundColor: const Color(0xFF1A1A2E),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: _Backdrop(backdropPath: detail.backdropPath),
          ),
        ),

        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster + title row
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Poster with Hero animation
                    Hero(
                      tag: _heroTag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 90,
                          height: 135,
                          child: detail.posterPath != null
                              ? CachedNetworkImage(
                                  imageUrl: ApiConstants.imageUrl(
                                    detail.posterPath,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: const Color(0xFF0F3460),
                                  child: const Icon(
                                    Icons.movie_outlined,
                                    color: Colors.white24,
                                    size: 32,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Title and genres
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Stats row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _StatsRow(detail: detail, isMovie: isMovie),
              ),

              const SizedBox(height: 16),

              // Genre chips
              if (detail.genres.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: detail.genres
                        .map((genre) => _GenreChip(genre: genre))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Overview
              if (detail.overview.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Sinopsis',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    detail.overview,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Tagline
              if (detail.tagline.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE50914).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: const Border(
                        left: BorderSide(color: Color(0xFFE50914), width: 3),
                      ),
                    ),
                    child: Text(
                      '"${detail.tagline}"',
                      style: const TextStyle(
                        color: Color(0xFFE50914),
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ] else
                const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the subtitle line below the title.
  /// Format: "Genre1 · Genre2 · Year"
  String get _subtitle {
    final year = detail.releaseDate.isNotEmpty && detail.releaseDate.length >= 4
        ? detail.releaseDate.substring(0, 4)
        : '';
    return year;
  }
}

/// Backdrop image with dark gradient overlay.
class _Backdrop extends StatelessWidget {
  const _Backdrop({required this.backdropPath});

  final String? backdropPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Backdrop image
        backdropPath != null
            ? CachedNetworkImage(
                imageUrl: ApiConstants.backdropUrl(backdropPath),
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const ColoredBox(color: Color(0xFF0F3460)),
                errorWidget: (context, url, error) =>
                    const ColoredBox(color: Color(0xFF0F3460)),
              )
            : const ColoredBox(color: Color(0xFF0F3460)),

        // Gradient overlay — fades to background color at bottom
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                const Color(0xFF1A1A2E).withValues(alpha: 0.6),
                const Color(0xFF1A1A2E),
              ],
              stops: const [0.4, 0.75, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}

/// Horizontal stats row showing rating, duration/seasons, and status.
class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.detail, required this.isMovie});

  final MediaDetail detail;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _StatItem(
              value: detail.voteAverage.toStringAsFixed(1),
              label: 'Rating',
              icon: Icons.star_rounded,
              iconColor: const Color(0xFFF5C518),
            ),
            const _Divider(),
            _StatItem(
              value: isMovie
                  ? detail.runtime != null
                        ? '${detail.runtime} min'
                        : 'N/A'
                  : detail.numberOfSeasons != null
                  ? '${detail.numberOfSeasons} temp.'
                  : 'N/A',
              label: isMovie ? 'Duración' : 'Temporadas',
              icon: isMovie ? Icons.access_time_rounded : Icons.tv_rounded,
            ),
            const _Divider(),
            _StatItem(
              value: detail.status,
              label: 'Estado',
              icon: Icons.info_outline_rounded,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    this.iconColor,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor ?? Colors.white54, size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Colors.white38, fontSize: 11),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 0.5, color: Colors.white.withValues(alpha: 0.15));
  }
}

/// Genre chip with subtle styling.
class _GenreChip extends StatelessWidget {
  const _GenreChip({required this.genre});

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Text(
        genre,
        style: const TextStyle(color: Colors.white70, fontSize: 12),
      ),
    );
  }
}
