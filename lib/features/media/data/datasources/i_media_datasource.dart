import 'package:moviedb_flutter_app/features/media/data/models/media_detail_model.dart';
import 'package:moviedb_flutter_app/features/media/data/models/movie_model.dart';
import 'package:moviedb_flutter_app/features/media/data/models/tv_show_model.dart';

abstract class IMediaDataSource {
  // Movies
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MediaDetailModel> getMovieDetail(int id);
  Future<List<MovieModel>> searchMovies(String query);

  // TV Shows
  Future<List<TvShowModel>> getPopularTvShows();
  Future<List<TvShowModel>> getTopRatedTvShows();
  Future<MediaDetailModel> getTvShowDetail(int id);
  Future<List<TvShowModel>> searchTvShows(String query);
}
