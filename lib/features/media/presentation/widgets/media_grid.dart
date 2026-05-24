import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb_flutter_app/core/router/app_router.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';
import 'package:moviedb_flutter_app/features/media/presentation/widgets/media_card.dart';

/// Grid of movie cards.
///
/// Navigates to the detail screen on tap, passing
/// the movie id and isMovie flag via go_router extra.
class MoviesGrid extends StatelessWidget {
  const MoviesGrid({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.55,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MediaCard(
          id: movie.id,
          title: movie.title,
          posterPath: movie.posterPath,
          voteAverage: movie.voteAverage,
          year: movie.releaseDate.isNotEmpty
              ? movie.releaseDate.substring(0, 4)
              : '',
          heroTag: 'movie_${movie.id}',
          onTap: () => context.push(
            AppRouter.detail,
            extra: {'id': movie.id, 'isMovie': true},
          ),
        );
      },
    );
  }
}

/// Grid of TV show cards.
class TvShowsGrid extends StatelessWidget {
  const TvShowsGrid({super.key, required this.tvShows});

  final List<TvShow> tvShows;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.58,
      ),
      itemCount: tvShows.length,
      itemBuilder: (context, index) {
        final tvShow = tvShows[index];
        return MediaCard(
          id: tvShow.id,
          title: tvShow.name,
          posterPath: tvShow.posterPath,
          voteAverage: tvShow.voteAverage,
          year: tvShow.firstAirDate.isNotEmpty
              ? tvShow.firstAirDate.substring(0, 4)
              : '',
          heroTag: 'tv_${tvShow.id}',
          onTap: () => context.push(
            AppRouter.detail,
            extra: {'id': tvShow.id, 'isMovie': false},
          ),
        );
      },
    );
  }
}