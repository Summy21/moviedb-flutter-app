import 'package:equatable/equatable.dart';

class TvShow extends Equatable {
  const TvShow({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.firstAirDate,
    required this.genreIds,
  });

  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final String firstAirDate;
  final List<int> genreIds;

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        backdropPath,
        voteAverage,
        voteCount,
        firstAirDate,
        genreIds,
      ];
}