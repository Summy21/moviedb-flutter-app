import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb_flutter_app/core/constants/api_constants.dart';
import 'package:moviedb_flutter_app/core/router/app_router.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/search_cubit.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/search_state.dart';
import 'package:moviedb_flutter_app/injection_container.dart';

/// Search screen for movies and TV shows.
///
/// Uses a debounced text field that triggers [SearchCubit.search]
/// after the user stops typing for 500ms — avoids firing a request
/// on every keystroke.
///
/// Results are split into two sections: movies and TV shows.
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SearchCubit>(),
      child: const _SearchContent(),
    );
  }
}

class _SearchContent extends StatefulWidget {
  const _SearchContent();

  @override
  State<_SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<_SearchContent> {
  final TextEditingController _controller = TextEditingController();

  /// Debounce timer to avoid firing on every keystroke.
  // ignore: cancel_subscriptions
  late final _debounce = _Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _controller.dispose();
    _debounce.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce.run(() {
      if (query.trim().isEmpty) {
        context.read<SearchCubit>().clear();
      } else {
        context.read<SearchCubit>().search(query.trim());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Buscar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Search input
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF16213E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: TextField(
                controller: _controller,
                autofocus: true,
                style: const TextStyle(color: Colors.white, fontSize: 15),
                cursorColor: const Color(0xFFE50914),
                decoration: InputDecoration(
                  hintText: 'Películas, series...',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.3),
                    fontSize: 15,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Colors.white38,
                    size: 22,
                  ),
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _controller,
                    builder: (context, value, child) {
                      return value.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Colors.white38,
                                size: 20,
                              ),
                              onPressed: () {
                                _controller.clear();
                                context.read<SearchCubit>().clear();
                              },
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
          ),

          // Results
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const _InitialView(),
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: Color(0xFFE50914)),
                  ),
                  loaded: (movies, tvShows) {
                    if (movies.isEmpty && tvShows.isEmpty) {
                      return _EmptyResultsView(query: _controller.text);
                    }
                    return _ResultsList(movies: movies, tvShows: tvShows);
                  },
                  error: (message) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Initial state — shown before the user types anything.
class _InitialView extends StatelessWidget {
  const _InitialView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.movie_filter_rounded,
            color: Colors.white12,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'Busca tus películas y series favoritas',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.3),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

/// Empty results view — shown when search returns no results.
class _EmptyResultsView extends StatelessWidget {
  const _EmptyResultsView({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.search_off_rounded, color: Colors.white24, size: 48),
          const SizedBox(height: 16),
          Text(
            'Sin resultados para "$query"',
            style: const TextStyle(color: Colors.white54, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

/// Scrollable list of results split by section.
class _ResultsList extends StatelessWidget {
  const _ResultsList({required this.movies, required this.tvShows});

  final List<Movie> movies;
  final List<TvShow> tvShows;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        if (movies.isNotEmpty) ...[
          _SectionHeader(label: 'Películas', count: movies.length),
          ...movies.map((movie) => _MovieListItem(movie: movie)),
        ],
        if (tvShows.isNotEmpty) ...[
          _SectionHeader(label: 'Series', count: tvShows.length),
          ...tvShows.map((tvShow) => _TvShowListItem(tvShow: tvShow)),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}

/// Section header with label and result count.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFE50914).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: const TextStyle(
                color: Color(0xFFE50914),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// List item for a movie result.
class _MovieListItem extends StatelessWidget {
  const _MovieListItem({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return _MediaListItem(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      subtitle: movie.releaseDate.isNotEmpty
          ? movie.releaseDate.substring(0, 4)
          : '',
      voteAverage: movie.voteAverage,
      heroTag: 'movie_${movie.id}',
      onTap: () => context.push(
        AppRouter.detail,
        extra: {'id': movie.id, 'isMovie': true},
      ),
    );
  }
}

/// List item for a TV show result.
class _TvShowListItem extends StatelessWidget {
  const _TvShowListItem({required this.tvShow});

  final TvShow tvShow;

  @override
  Widget build(BuildContext context) {
    return _MediaListItem(
      id: tvShow.id,
      title: tvShow.name,
      posterPath: tvShow.posterPath,
      subtitle: tvShow.firstAirDate.isNotEmpty
          ? tvShow.firstAirDate.substring(0, 4)
          : '',
      voteAverage: tvShow.voteAverage,
      heroTag: 'tv_${tvShow.id}',
      onTap: () => context.push(
        AppRouter.detail,
        extra: {'id': tvShow.id, 'isMovie': false},
      ),
    );
  }
}

/// Reusable horizontal list item for search results.
class _MediaListItem extends StatelessWidget {
  const _MediaListItem({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.subtitle,
    required this.voteAverage,
    required this.heroTag,
    required this.onTap,
  });

  final int id;
  final String title;
  final String? posterPath;
  final String subtitle;
  final double voteAverage;
  final String heroTag;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Row(
          children: [
            // Poster with Hero
            Hero(
              tag: heroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  width: 48,
                  height: 72,
                  child: posterPath != null
                      ? CachedNetworkImage(
                          imageUrl: ApiConstants.imageUrl(posterPath),
                          fit: BoxFit.cover,
                          placeholder: (_, __) =>
                              const ColoredBox(color: Color(0xFF0F3460)),
                          errorWidget: (_, __, ___) =>
                              const ColoredBox(color: Color(0xFF0F3460)),
                        )
                      : const ColoredBox(
                          color: Color(0xFF0F3460),
                          child: Icon(
                            Icons.movie_outlined,
                            color: Colors.white24,
                            size: 20,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Rating
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFF5C518),
                  size: 14,
                ),
                const SizedBox(width: 3),
                Text(
                  voteAverage.toStringAsFixed(1),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple debouncer to delay search requests.
///
/// Cancels the previous timer when a new call arrives —
/// only fires after [milliseconds] of inactivity.
class _Debouncer {
  _Debouncer({required this.milliseconds});

  final int milliseconds;
  dynamic _timer;

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
