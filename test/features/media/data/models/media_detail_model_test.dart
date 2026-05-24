import 'package:flutter_test/flutter_test.dart';
import 'package:moviedb_flutter_app/features/media/data/models/media_detail_model.dart';

void main() {
  const tMovieJson = {
    'id': 550,
    'title': 'Fight Club',
    'overview': 'An insomniac office worker.',
    'poster_path': '/poster.jpg',
    'backdrop_path': '/backdrop.jpg',
    'vote_average': 8.438,
    'vote_count': 32014,
    'genres': [
      {'id': 18, 'name': 'Drama'},
      {'id': 53, 'name': 'Thriller'},
    ],
    'status': 'Released',
    'tagline': 'Mischief. Mayhem. Soap.',
    'release_date': '1999-10-15',
    'runtime': 139,
  };

  const tTvJson = {
    'id': 1396,
    'name': 'Breaking Bad',
    'overview': 'A chemistry teacher turned drug manufacturer.',
    'poster_path': '/poster.jpg',
    'backdrop_path': '/backdrop.jpg',
    'vote_average': 8.944,
    'vote_count': 17762,
    'genres': [
      {'id': 18, 'name': 'Drama'},
      {'id': 80, 'name': 'Crime'},
    ],
    'status': 'Ended',
    'tagline': 'Remember my name.',
    'first_air_date': '2008-01-20',
    'number_of_seasons': 5,
    'number_of_episodes': 62,
  };

  group('MediaDetailModel.fromMovieJson', () {
    test('parses movie fields correctly', () {
      final model = MediaDetailModel.fromMovieJson(tMovieJson);

      expect(model.id, 550);
      expect(model.title, 'Fight Club');
      expect(model.runtime, 139);
      expect(model.releaseDate, '1999-10-15');
      expect(model.numberOfSeasons, isNull);
      expect(model.numberOfEpisodes, isNull);
    });

    test('extracts genre names from nested objects', () {
      final model = MediaDetailModel.fromMovieJson(tMovieJson);
      expect(model.genres, ['Drama', 'Thriller']);
    });
  });

  group('MediaDetailModel.fromTvJson', () {
    test('parses TV show fields correctly', () {
      final model = MediaDetailModel.fromTvJson(tTvJson);

      expect(model.id, 1396);
      // Maps "name" to title
      expect(model.title, 'Breaking Bad');
      // Maps "first_air_date" to releaseDate
      expect(model.releaseDate, '2008-01-20');
      expect(model.numberOfSeasons, 5);
      expect(model.numberOfEpisodes, 62);
      expect(model.runtime, isNull);
    });

    test('extracts genre names from nested objects', () {
      final model = MediaDetailModel.fromTvJson(tTvJson);
      expect(model.genres, ['Drama', 'Crime']);
    });
  });

  group('MediaDetailModel.toEntity', () {
    test('movie model converts to entity correctly', () {
      final model = MediaDetailModel.fromMovieJson(tMovieJson);
      final entity = model.toEntity();

      expect(entity.title, 'Fight Club');
      expect(entity.genres, ['Drama', 'Thriller']);
      expect(entity.runtime, 139);
      expect(entity.numberOfSeasons, isNull);
    });

    test('tv model converts to entity correctly', () {
      final model = MediaDetailModel.fromTvJson(tTvJson);
      final entity = model.toEntity();

      expect(entity.title, 'Breaking Bad');
      expect(entity.numberOfSeasons, 5);
      expect(entity.runtime, isNull);
    });
  });
}
