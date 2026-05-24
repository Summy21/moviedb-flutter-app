import 'package:flutter_test/flutter_test.dart';
import 'package:moviedb_flutter_app/features/media/data/models/movie_model.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';

void main() {
  // Sample JSON matching real TMDB response structure
  const tJson = {
    'id': 550,
    'title': 'Fight Club',
    'overview': 'An insomniac office worker forms a fight club.',
    'poster_path': '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
    'backdrop_path': '/hZkgoQYus5vegHoetLkCJzb17zJ.jpg',
    'vote_average': 8.438,
    'vote_count': 32014,
    'release_date': '1999-10-15',
    'genre_ids': [18, 53],
  };

  // Sample JSON with nullable fields missing
  const tJsonNullable = {
    'id': 551,
    'title': 'Unknown Movie',
    'overview': null,
    'poster_path': null,
    'backdrop_path': null,
    'vote_average': 0.0,
    'vote_count': null,
    'release_date': null,
    'genre_ids': null,
  };

  group('MovieModel.fromJson', () {
    test('parses all fields correctly from valid JSON', () {
      final model = MovieModel.fromJson(tJson);

      expect(model.id, 550);
      expect(model.title, 'Fight Club');
      expect(model.overview, 'An insomniac office worker forms a fight club.');
      expect(model.posterPath, '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg');
      expect(model.backdropPath, '/hZkgoQYus5vegHoetLkCJzb17zJ.jpg');
      expect(model.voteAverage, 8.438);
      expect(model.voteCount, 32014);
      expect(model.releaseDate, '1999-10-15');
      expect(model.genreIds, [18, 53]);
    });

    test('handles null optional fields with default values', () {
      final model = MovieModel.fromJson(tJsonNullable);

      expect(model.posterPath, isNull);
      expect(model.backdropPath, isNull);
      expect(model.overview, '');
      expect(model.voteCount, 0);
      expect(model.releaseDate, '');
      expect(model.genreIds, isEmpty);
    });

    test('converts vote_average from int to double correctly', () {
      final json = {...tJson, 'vote_average': 8};
      final model = MovieModel.fromJson(json);
      expect(model.voteAverage, 8.0);
      expect(model.voteAverage, isA<double>());
    });
  });

  group('MovieModel.toEntity', () {
    test('converts model to Movie entity correctly', () {
      final model = MovieModel.fromJson(tJson);
      final entity = model.toEntity();

      expect(entity, isA<Movie>());
      expect(entity.id, model.id);
      expect(entity.title, model.title);
      expect(entity.overview, model.overview);
      expect(entity.posterPath, model.posterPath);
      expect(entity.voteAverage, model.voteAverage);
      expect(entity.genreIds, model.genreIds);
    });

    test('entity equality works correctly via Equatable', () {
      final model1 = MovieModel.fromJson(tJson);
      final model2 = MovieModel.fromJson(tJson);

      expect(model1.toEntity(), equals(model2.toEntity()));
    });
  });
}
